{ config, pkgs, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
      dns = "none";
    };
    nameservers = [
      "9.9.9.9"
#      "192.168.178.208" #point to ares or another unbound instance
      "192.168.178.1" #point to router -> dhcp -> dns
    ];
    hosts = {
      "192.168.178.204" = [ "hector"];
      "192.168.178.205" = [ "workstation" ];
      "192.168.178.206" = [ "embla" ];
      "192.168.178.207" = [ "corvus"];
      "192.168.178.208" = [ "ares"];
    };
  };

  services.resolved.enable = false;

  services.dnscrypt-proxy2 = {
    enable = false;
    settings = {
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      # server_names = [ ... ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
}
