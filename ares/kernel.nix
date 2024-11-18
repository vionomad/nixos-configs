{ config, pkgs, ... }:

{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 20;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_6_6_hardened;

  # hardened kernel forbids users from creating namespaces therefor logrotate can't checkConfig
  services.logrotate.checkConfig = false;

  boot.initrd = {
    availableKernelModules = [
      "aesni_intel"
      "cryptd"
      "e1000e" #load module for network card for ssh setup, "lspci -v | grep -iA8 'network\|ethernet'"
    ];
    network = {
      enable = true;
      udhcpc.enable = true;
      flushBeforeStage2 = true;
      ssh = {
        enable = true;
    port = 22;
    authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJS7eS1HQak4BkBDk4UPDdd6h5BMMpjIQUnIvPAdMVa+ yejii@workstation" ];
    hostKeys = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };
      postCommands = ''
        echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
    '';
    };
  };
}
