{ config, pkgs, ...}:

{
  services.jellyfin = {
    enable = true;
    user="yejii";
  };

  nixpkgs.overlays = with pkgs; [
    (
      final: prev:
        {
          jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
            installPhase = ''
              runHook preInstall

              # this is the important line
              sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

              mkdir -p $out/share
              cp -a dist $out/share/jellyfin-web

              runHook postInstall
            '';
          });
        }
    )
  ];

  services.nginx.virtualHosts = {
    "jellyfin.brotto.duckdns.org" = {
      locations."/".proxyPass = "http://127.0.0.1:8096";
      addSSL = true;
      enableACME = true;
      kTLS = true;
      acmeRoot = null;
    };

    "cdnjellyfin.duckdns.org" = {
      locations."/".proxyPass = "http://127.0.0.1:8096";
      addSSL = true;
      enableACME = true;
      kTLS = true;
      acmeRoot = null;
    };
  };

  networking.firewall.allowedUDPPorts = [
    1900
    7359
  ];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web
  ];

}
