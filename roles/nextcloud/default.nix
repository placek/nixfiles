{ config, pkgs, ... }:

{
  security.acme.acceptTerms = true;
  security.acme.email       = "placzynski.pawel@gmail.com";

  services.nginx.virtualHosts."nextcloud.placki.cloud" = {
    forceSSL   = true;
    enableACME = true;
  };

  services.nextcloud = {
    enable                 = true;
    hostName               = "nextcloud.placki.cloud";
    https                  = true;
    autoUpdateApps.enable  = true;
    autoUpdateApps.startAt = "03:00:00";
    package                = pkgs.nextcloud20;

    config = {
      overwriteProtocol = "https";
      dbtype            = "pgsql";
      dbuser            = "nextcloud";
      dbhost            = "/run/postgresql";
      dbname            = "nextcloud";
      dbpassFile        = "/var/nextcloud-db-pass";
      adminpassFile     = "/var/nextcloud-admin-pass";
      adminuser         = "admin";
    };
  };

  services.postgresql = {
    enable          = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers     = [ { name = "nextcloud"; ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES"; } ];
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after    = ["postgresql.service"];
  };
}
