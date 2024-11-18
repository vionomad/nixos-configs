{ config, pkgs, ...}:
{
  services.nginx.virtualHosts = {
    "files.brotto.duckdns.org" = {
      locations."/" = {
        root = "/var/www/files";
	extraConfig = "autoindex on;";
      };
      forceSSL = true;
      acmeRoot = null;
      enableACME = true;
      kTLS = true;
    };
  };
}
