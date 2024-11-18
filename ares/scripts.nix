{ config, pkgs, ...}:
{
  environment.systemPackages = let
    openLuks = pkgs.writeScriptBin "open_luks" ''
      #/usr/bin/env bash
      sudo cryptsetup luksOpen /dev/disk/by-uuid/e58b1d5a-07ed-4542-9f47-5b0d28ff73b3 archive
      #sudo cryptsetup luksOpen /dev/disk/by-uuid/1b80c4b6-ad8f-4979-880a-e658a5b773b9 movies_1
      #sudo cryptsetup luksOpen /dev/disk/by-uuid/e1b98c9c-611e-4e89-8795-07670b123a70 movies_2
      sudo cryptsetup luksOpen /dev/disk/by-uuid/e5110303-55f8-482a-b13d-16cfeb7fac66 rudi
      sudo cryptsetup luksOpen /dev/disk/by-uuid/e418bf59-7c8b-47cc-bfc6-18ffcabe6f70 triangles
      sudo mount /dev/mapper/archive /media/archive
      #sudo mount /dev/torrent_movies_backup/4tb_striped /media/movies
      sudo mount /dev/mapper/rudi /media/movies_backup
      sudo mount /dev/mapper/triangles /media/triangles
      #sudo mount --bind /media/archive /srv/export/archive
      #sudo mount --bind /media/movies /srv/export/movies
      #sudo mount --bind /media/movies_backup /srv/export/movies_backup
      #sudo mount --bind -o ro /media/archive/iso /mount/archive/iso

      sudo exportfs -arv
    '';
    test = pkgs.writeScriptBin "testHelloWorld" ''
      #!/usr/bin/env bash
      echo "Hello World!"
    '';
  in [
    openLuks
    test
  ];
}
