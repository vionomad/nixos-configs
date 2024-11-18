{ config, pkgs, ...}:
{
  services.chrony = {
    enable = true;
    enableNTS = true;
    servers = [
      "ptbtime1.ptb.de"
      "nts.ntp.se"
      "ptbtime2.ptb.de"
      "ptbtime3.ptb.de"
      "ptbtime4.ptb.de"
      "time.cloudflare.com"
    ];
  };
}
