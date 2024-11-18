{ config, pkgs, ...}:
{
  virtualisation.oci-containers = {
    containers = {
      nextcloud = {
        image = "lscr.io/linuxserver/nextcloud:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Amsterdam";
        };
        volumes = [
          "/var/lib/nextcloud/config:/config"
          "/var/lib/nextcloud/data:/data"
        ];
        ports = [
          "8876:443"
        ];
        autoStart = false;
        extraOptions = [
          "--pull=newer"
        ];
      };
    };
  };

  services.nginx.virtualHosts = {
    "cdnextcloud.duckdns.org" = {
      locations."/".proxyPass = "https://127.0.0.1:8876";
      forceSSL = true;
      enableACME = true;
      acmeRoot = null;
      kTLS = true;
    };
  };

}
