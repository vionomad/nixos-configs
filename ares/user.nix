{ config, pkgs, ...}:
{
  users.users = {

    yejii = {
      hashedPassword = "$y$j9T$.DoIceXLmXhQQu4PXeiTB/$XrNaR6VnR2b6yMS6WTLLBAkcSXvKIcBrV2l1sw4DK19";
      isNormalUser = true;
      description = "yejii";
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJS7eS1HQak4BkBDk4UPDdd6h5BMMpjIQUnIvPAdMVa+ yejii@workstation"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCXDhv/CDwntEJGKlUcrLUjgfhVXY9pV/EO5vppJ0PV yejii@hector"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDc+miqyrIpA501CAPI8+YEsTbXTG31+e5GgRvCo54dF yejii@embla"
      ];
    };

    grafana = {
      isNormalUser = true;
      description = "grafana docker user";
    };

  };
}
