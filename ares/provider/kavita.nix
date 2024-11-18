{ config, pkgs, ... }:
{
  virtualisation.oci-containers = {
    containers = {

      kavita = {
        image = "lscr.io/linuxserver/kavita:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Amsterdam";
        };
        volumes = [
          "/var/lib/kavita/config:/config"
          "/var/lib/kavita/data:/data"
          "/media/archive/manga:/manga:ro"
          "/media/archive/Books:/books:ro"
          "/media/archive/comics:/comics:ro"
        ];
        autoStart = false;
        ports = [ "5000:5000" ];
        extraOptions = [
#          "--network=container:wireguard"
          "--pull=newer"
        ];
#        dependsOn = [ "wireguard" ];
      };

#      wireguard.ports = [ "5000:5000" ];
      
    };
  };

  services.nginx.virtualHosts = {
    "kavita.brotto.duckdns.org" = {
      locations."/".proxyPass = "http://127.0.0.1:5000";
      enableACME = true;
      forceSSL = true;
      acmeRoot = null;
      kTLS = true;
    };
  };

}
