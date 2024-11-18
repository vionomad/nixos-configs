{ config, pkgs, ...}:
{
  virtualisation = {
    podman = {
      enable = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {

      zotero = {
        image = "lscr.io/linuxserver/zotero:latest";
        autoStart = false;
        ports = [
          "7070:3000" #http
          "7071:3001" #https
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Amsterdam";
        };
        volumes = [
          "/var/lib/zotero/config:/config"
        ];
        extraOptions = [
          "--pull=newer"
          "--shm-size=1gb"
        ];
      };

    };
  };

}
