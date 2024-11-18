{ config, pkgs, ... }:
{
  virtualisation.oci-containers = {
    containers = {
      jellyfin = {
        image = "lscr.io/linuxserver/jellyfin:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Amsterdam";
        };
        volumes = [
          "/var/lib/jellyfin:/config"
          "/media/archive/manga:/media/archive/manga:ro"
          "/media/archive/Books:/media/archive/books:ro"
          "/media/archive/comics:/media/archive/comics:ro"
          "/media/archive/music:/media/archive/music:ro"
          "/media/archive/qbit:/media/archive/qbit:ro"
          "/media/movies_backup:/media/movies_backup:ro"
          "/media/triangles:/media/triangles:ro"
        ];
        autoStart = false;
        extraOptions = [
#          "--network=container:wireguard"
          "--pull=newer"
          "--device=/dev/dri:/dev/dri"
        ];
        ports = [
          "8096:8096"
	  "1900:1900/udp"
	  "7359:7359/udp"
        ];
#        dependsOn = [ "wireguard" ];
      };
    };
  };

  services.nginx.virtualHosts = {

    "jellyfin.brotto.duckdns.org" = {
      locations."/".proxyPass = "http://127.0.0.1:8096";
      forceSSL = true;
      enableACME = true;
      acmeRoot = null;
      kTLS = true;
    };

    "cdnjellyfin.duckdns.org" = {
      locations."/".proxyPass = "http://127.0.0.1:8096";
      forceSSL = true;
      enableACME = true;
      acmeRoot = null;
      kTLS = true;
    };

  };

  networking.firewall.allowedUDPPorts = [ 
    1900
    7359
  ];

}
