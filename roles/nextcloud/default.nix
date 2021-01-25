{ config, pkgs, ... }:

{
  security.acme.acceptTerms = true;
  security.acme.email       = "placzynski.pawel@gmail.com";

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";
    virtualHosts = {
      "nextcloud.placki.cloud" = {
        forceSSL = true;
        enableACME = true;
      };
    };
  };

  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.example.com";
    nginx.enable = true;
    https = true;
    autoUpdateApps.enable = true;
    autoUpdateApps.startAt = "03:00:00";

    config = {
      overwriteProtocol = "https";
      dbtype     = "pgsql";
      dbuser     = "nextcloud";
      dbhost     = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname     = "nextcloud";
      dbpassFile = "/var/nextcloud-db-pass";
      adminpassFile = "/var/nextcloud-admin-pass";
      adminuser = "admin";
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      { name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
    ];
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };
}
