{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
    curl
    fd
    duf
    mpv
    streamlink
    wtwitch
    htop
    btop
    libva-utils
    intel-gpu-tools
    vdpauinfo
    jellyfin-media-player
    dust
    bat
    lm_sensors
    dig
    nftables
    openssl
    tcpdump
    pciutils
    lsd
    fastfetch
    fzf
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
    lego
  ];

  fonts.packages = with pkgs; [
    hack-font
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

}
