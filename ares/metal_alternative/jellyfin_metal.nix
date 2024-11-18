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

#  services.caddy = {
#    virtualHosts."cdnjellyfin.duckdns.org".extraConfig = ''
#      reverse_proxy http://127.0.0.1:8096
#      tls {
#        dns duckdns 3c19a807-48ab-449b-8528-6ef518700ffb
#	}
#    '';
#  };

  services.nginx.virtualHosts."jellyfin.internal" = {
    locations."/".proxyPass = "http://127.0.0.1:8096";
    addSSL = true;
#    enableACME = true;
    kTLS = true;
    sslCertificate = "/var/lib/kavita/ssl/kavita.crt";
    sslCertificateKey = "/var/lib/kavita/ssl/kavita.key";
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web
  ];

}
