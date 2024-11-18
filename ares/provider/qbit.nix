{ config, pkgs, ...}:
let
  webui = 8080;
  torrenting = 6881;
in {
  virtualisation.oci-containers = {
    containers = {
      qbittorrent = {
        image = "lscr.io/linuxserver/qbittorrent:latest";
        autoStart = false;
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Amsterdam";
          WEBUI_PORT = "${toString webui}";
	  TORRENTING_PORT = "${toString torrenting}";
        };
        volumes = [
          "/var/lib/qbit:/config"
#          "/media/movies:/media/movies"
          "/media/movies_backup:/media/movies_backup"
          "/media/archive/manga:/media/archive/manga"
          "/media/archive/Books:/media/archive/Books"
          "/media/archive/comics:/media/archive/comics"
          "/media/triangles:/media/triangles"
        ];
        extraOptions = [
          "--network=container:wireguard"
          "--pull=newer"
        ];
        dependsOn = [ "wireguard" ];
      };

      wireguard.ports = [
        "${toString webui}:${toString webui}"
	"${toString torrenting}:${toString torrenting}"
	"${toString torrenting}:${toString torrenting}/udp"
      ];

    };
  };

  services.nginx.virtualHosts = {
    "qbit.brotto.duckdns.org" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString webui}";
        extraConfig = ''proxy_set_header   Host               $proxy_host;
                        proxy_set_header   X-Forwarded-For    $proxy_add_x_forwarded_for;
                        proxy_set_header   X-Forwarded-Host   $http_host;
                        proxy_set_header   X-Forwarded-Proto  $scheme;
                      '';
      };
      forceSSL = true;
      enableACME = true;
      acmeRoot = null;
      kTLS = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ torrenting ];
  networking.firewall.allowedUDPPorts = [ torrenting ];

}
