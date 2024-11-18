{ config, pkgs, ... }:
{
  services.prometheus = {
    enable = true;
    port = 3001;
    exporters = {

      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 3002;
      };

      smartctl = {
        enable = true;
        port = 3003;
      };

      unbound = {
        enable = true;
        port = 3004;
        unbound = {
          host = "unix:///run/unbound/unbound.ctl";
        };
      };

    };
    scrapeConfigs = [
      {
        job_name = "${toString config.networking.hostName}";
        static_configs = [{
          targets = [
            "127.0.0.1:${toString config.services.prometheus.exporters.node.port}"
            "127.0.0.1:${toString config.services.prometheus.exporters.smartctl.port}"
            "127.0.0.1:${toString config.services.prometheus.exporters.unbound.port}"
          ];
        }];
      }
    ];
  };

  services.nginx.virtualHosts = {
    "${toString config.networking.hostName}.prometheus.brotto.duckdns.org" = {
      locations."/".proxyPass = "http://127.0.0.1:3001";
      forceSSL = true;
      enableACME = true;
      acmeRoot = null;
      kTLS = true;
    };
  };

}
