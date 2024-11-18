{ config, pkgs, ...}:
{
  networking.firewall.allowedTCPPorts = [
    80 #nginx
    443 #https nginx
  ];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    sslDhparam = "/var/lib/ssl/dhparam.pem";

  };

}
