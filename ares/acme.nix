{ config, pkgs, ...}:
{

  age.secrets.duckdns.file = /home/yejii/secrets/duckdns.age;

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "vionomad@protonmail.com";
      dnsResolver = "9.9.9.9:53";
#      server = "https://acme-staging-v02.api.letsencrypt.org/directory";
      dnsProvider = "duckdns";
      dnsPropagationCheck = true;
      environmentFile = config.age.secrets.duckdns.path;
    };
    certs = {
      
#      "brotto.duckdns.org" = {
#        domain = "*.brotto.duckdns.org";
#        extraDomainNames = [ "*.brotto.duckdns.org" ];
#        group = config.services.nginx.group;
#        environmentFile = config.age.secrets.duckdns.path;
#      };
      
#      "cdnjellyfin.duckdns.org" = {
#        domain = "cdnjellyfin.duckdns.org";
#        group = config.services.nginx.group;
#	dnsPropagationCheck = true;
#        credentialsFile = config.age.secrets.duckdns.path;
#      };
    
    };
  };

}
