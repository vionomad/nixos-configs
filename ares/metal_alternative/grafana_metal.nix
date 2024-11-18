{ config, pkgs, ...}:
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        # Listening Address
        http_addr = "127.0.0.1";
        # and Port
        http_port = 3333;
        # Grafana needs to know on which domain and URL it's running
        domain = "localhost";
        serve_from_sub_path = true;
      };
    };
    declarativePlugins = with pkgs.grafanaPlugins; [
      grafana-piechart-panel
    ];
  };

  services.nginx = {
    virtualHosts = {
      "grafana.internal" = {
        locations."/".proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
        addSSL = true;
        sslCertificate = "/var/lib/ssl/brotto.crt";
        sslCertificateKey = "/var/lib/ssl/brotto.key";
        kTLS = true;
      };
    };
  };
}
