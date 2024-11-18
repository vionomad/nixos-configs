{ config, pkgs, ... }:
{
  virtualisation.oci-containers = {
    containers = {
      vaultwarden = {
        image = "docker.io/vaultwarden/server:latest";
        environment = {
          DOMAIN = "https://pass.brotto.duckdns.org";
          SIGNUPS_ALLOWED = "true";
          INVITATIONS_ALLOWED = "true";
          SIGNUPS_VERIFY = "false"; # verify through email
          WEBSOCKET_ENABLED = "true";
          WEBSOCKET_ADDRESS = "0.0.0.0";
          WEBSOCKET_PORT = "3012";
          LOG_FILE = "/var/log/vaultwarden";
          ADMIN_TOKEN = "$argon2id$v=19$m=19456,t=2,p=1$wxOwMNKp4Lho8X16NnK5tyL1V/2FqIccPnPFz1LlS4Q$dwUuuVrzWxFXw2HPlOVkxCi3aI/hgEhxogLIWz8yYFE";
        };
        volumes = [
          "/var/lib/vaultwarden:/data"
        ];
        autoStart = false;
	ports = [ "8834:80" ];
        extraOptions = [
#          "--network=container:wireguard"
	  "--pull=newer"
        ];
#	dependsOn = [ "wireguard" ];
      };

#      wireguard.ports = [ "8834:80" ];

    };
  };

  services.nginx.virtualHosts = {
    "pass.brotto.duckdns.org" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8834";
        proxyWebsockets = true;
      };
      forceSSL = true;
      kTLS = true;
      enableACME = true;
      acmeRoot = null;
    };
  };

}
