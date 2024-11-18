{ config, pkgs, ...}:
{
  virtualisation.oci-containers = {
    containers = {
      wireguard = {
        image = "lscr.io/linuxserver/wireguard:latest";
        autoStart = false;
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Amsterdam";
        };
        volumes = [
          "/var/lib/wireguard:/config"
          "/run/current-system/kernel-modules/lib/modules:/lib/modules"
        ];
        ports = [
        ];
        extraOptions = [
          "--cap-add=NET_ADMIN"
          "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
          "--pull=newer"
        ];
      };
    };
  };
}
