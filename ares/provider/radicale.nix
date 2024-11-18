{ config, pkgs, ...}:
{
  services.radicale = {
    enable = true;
    settings = {
      server.hosts = [ "127.0.0.1:5232" ];
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/var/lib/radicale/users";
        htpasswd_encryption = "bcrypt";
      };
      storage = {
        filesystem_folder = "/var/lib/radicale/collections";
      };
    };
  };

  services.nginx.virtualHosts = {
    "radicale.brotto.duckdns.org" = {
      locations."/" = {
	proxyPass = "http://127.0.0.1:5232";
	extraConfig = ''
	  proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header  Host $host;
          proxy_pass_header Authorization;
        '';
      };
      forceSSL = true;
      kTLS = true;
      enableACME = true;
      acmeRoot = null;
    };
  };

}
