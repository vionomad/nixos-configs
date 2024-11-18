{ config, pkgs, ... }:
{
  virtualisation.oci-containers = {
    containers = {
      grafana = {
        image = "grafana/grafana:latest";
        volumes = [
          "/var/lib/grafana:/var/lib/grafana"
        ];
        ports = [
          "3000:3000"
        ];
        autoStart = false;
        extraOptions = [
          "--pull=newer"
        ];
      };
    };
  };

  services.nginx.virtualHosts = {
    "grafana.brotto.duckdns.org" = {
      locations."/".proxyPass = "http://127.0.0.1:3000";
      forceSSL = true;
      enableACME = true;
      acmeRoot = null;
      kTLS = true;
    };
  };
}
