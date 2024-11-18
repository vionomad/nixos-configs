{ config, pkgs, ...}:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = [ "yejii" ];
      UseDns = true;
      PermitRootLogin = "no";
      X11Forwarding = false;
      UsePAM = false;
      AuthenticationMethods = "publickey";
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
}
