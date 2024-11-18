{ config, pkgs, ... }:

let

  stateDir = "/var/lib/unbound";

  adblockLocalZones = pkgs.stdenv.mkDerivation {
    name = "adblock";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts";
      sha256 = "82f05eee85f179d9135b385b150f972b09a8986e63d6fd2d3e05963dcfb443a2";
      };
    dontUnpack = true;
    buildPhase = ''
        cat $src | ${pkgs.gawk}/bin/awk '{sub(/\r$/,"")} {sub(/^127\.0\.0\.1/,"0.0.0.0")} BEGIN { OFS = "" } NF == 2 && $1 == "0.0.0.0" { print "local-zone: \"", $2, "\" static"}'  | tr '[:upper:]' '[:lower:]' | sort -u > zones
    '';
    installPhase = ''
      sed -i '1s/^/server:\n/' zones
      mv zones $out
    '';
  };

in {

  services.unbound = {
    enable = true;
    enableRootTrustAnchor = true;
    localControlSocketPath = "/run/unbound/unbound.ctl";
    settings = {
      server = {
        interface = [ 
          "127.0.0.1"
          "192.168.178.208"
        ];
        port = 53;
        access-control = [
          "192.168.178.0/24 allow"
        ];
        verbosity = 2;
        do-ip4 = true;
        do-ip6 = true;
        do-udp = true;
        do-tcp = true;
#        local-zone = "internal. static";
#        local-data = "grafana.internal. IN A 192.168.178.204";        
        ssl-cert-bundle = "/etc/ssl/certs/ca-certificates.crt";
        harden-glue = true;
        harden-dnssec-stripped = true;
        prefetch = true;
        edns-buffer-size = 1232;
        hide-identity = true;
        hide-version = true;
      };

      remote-control = {
        control-enable = true;
        control-interface = "/run/unbound/unbound.ctl";
      };

      #define where requests outside of local auth are are resolved, using quad9 for resilience but others should be used as well
      forward-zone = [
        {
          name = ".";
          forward-addr = [
            "9.9.9.9#dns.quad9.net"
            "149.112.112.112#dns.quad9.net"
            "46.182.19.48#digitalcourage.de"
          ];
          forward-ssl-upstream = true;  # Protected DNS
        }
      ];

      #create authoritative zone for local resolving and use zonefile for it (alternative is using local-zone/local-data
      auth-zone = [
        {
          name = "internal";
          zonefile = "/var/lib/unbound/internal.zone";
        }
      ];

      #include derived and formated file for hosts to be blocked, meaning resolved to nowhere
      include = "${adblockLocalZones}";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
}
