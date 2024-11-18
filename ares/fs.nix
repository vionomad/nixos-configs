{ config, pkgs, ... }:
{
  fileSystems."/media/archive" = {
    device = "ares:/archive";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "rw" ];
  };

  fileSystems."/media/movies_backup" = {
    device = "ares:/movies_backup";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "rw" ];
  };

  fileSystems."/media/triangles" = {
    device = "ares:/triangles";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "rw" ];
  };
}
