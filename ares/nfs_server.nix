{ config, pkgs, ...}:
{
  services.nfs.server = {
    enable = true;
    exports = ''
      /media                192.168.178.205(rw,fsid=0,no_subtree_check,sync)
      /media/archive        192.168.178.205(rw,no_subtree_check,nohide,sync)
      /media/movies_backup  192.168.178.205(rw,no_subtree_check,nohide,sync)
      /media/triangles      192.168.178.205(rw,no_subtree_check,nohide,sync)
    '';
    #/media/movies      192.168.178.205(rw,no_subtree_check,nohide,sync) 192.168.178.206(ro,no_subtree_check,nohide,sync)
  };

  networking.firewall.allowedTCPPorts = [ 2049 ];
}
