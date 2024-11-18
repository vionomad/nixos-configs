# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/chron.nix
      /etc/nixos/dns.nix
      /etc/nixos/provider/grafana.nix
      /etc/nixos/provider/jellyfin.nix
      /etc/nixos/provider/kavita.nix
      /etc/nixos/kernel.nix
      /etc/nixos/networking.nix
      /etc/nixos/provider/nextcloud.nix
      /etc/nixos/nfs_server.nix
      /etc/nixos/nginx.nix
      /etc/nixos/packages.nix
      /etc/nixos/podman.nix
      /etc/nixos/provider/prometheus.nix
      /etc/nixos/provider/qbit.nix
      /etc/nixos/provider/radicale.nix
      /etc/nixos/scripts.nix
      /etc/nixos/ssh.nix
      /etc/nixos/user.nix
      /etc/nixos/provider/vaultwarden.nix
      /etc/nixos/wireguard.nix
      <agenix/modules/age.nix>
      /etc/nixos/acme.nix
      /etc/nixos/provider/files.nix
    ];

  boot.initrd.luks.devices."luks-d5983294-5ef9-44a4-be24-680f6c96a2b1".device = "/dev/disk/by-uuid/d5983294-5ef9-44a4-be24-680f6c96a2b1";

  networking.hostName = "ares";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
