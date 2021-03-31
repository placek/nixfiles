{ config, pkgs, ... }:

{
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  virtualisation.docker.autoPrune.dates = "daily";
  virtualisation.docker.enable          = true;

  networking.domain      = "local";
  networking.nameservers = [ "127.0.0.1" "8.8.8.8" ];

  networking.firewall = {
    enable            = true;
    allowPing         = true;
    trustedInterfaces = [ "eno2" "eno3" "eno4" ];
    checkReversePath  = false;
    allowedTCPPorts   = [
      22    # ssh
      80    # http
      443   # https
      2222  # git
    ];
    allowedUDPPorts = [ ];
  };

  networking.nat = {
    enable = true;
    internalIPs = [ "192.168.2.0/24" "192.168.3.0/24" "192.168.4.0/24" ];
    externalInterface = "eno1";
  };

  networking.interfaces = {
    eno1 = {
      useDHCP = true;
    };

    eno2 = {
      ipv4.addresses = [ { address = "192.168.2.1"; prefixLength = 24; } ];
    };

    eno3 = {
      ipv4.addresses = [ { address = "192.168.3.1"; prefixLength = 24; } ];
    };

    eno4 = {
      ipv4.addresses = [ { address = "192.168.4.1"; prefixLength = 24; } ];
    };
  };

  services.dnsmasq = {
    enable      = true;
    servers     = [ "8.8.8.8" "8.8.4.4" ];
    extraConfig = builtins.readFile ./sources/dnsmasq_config;
  };

  services.nginx = {
    enable                   = true;
    recommendedGzipSettings  = true;
    recommendedOptimisation  = true;
    recommendedProxySettings = true;
    recommendedTlsSettings   = true;
    sslCiphers               = "AES256+EECDH:AES256+EDH:!aNULL";

    virtualHosts."app.placki.cloud" = {
      forceSSL      = true;
      enableACME    = true;
      locations."/" = { proxyPass = "http://localhost:8080"; };
    };
  };

  systemd.services.nginx-app-proxy = {
    description = "Nginx apps reverse proxy";
    wantedBy    = [ "multi-user.target" ];
    after       = [ "docker.service" "docker.socket" ];
    requires    = [ "docker.service" "docker.socket" ];
    preStop     = "${pkgs.docker}/bin/docker stop nginx-proxy";
    reload      = "${pkgs.docker}/bin/docker restart nginx-proxy";
    script      = ''
      exec ${pkgs.docker}/bin/docker run \
          --rm \
          --name=nginx-proxy \
          --network=nginx-proxy_net \
          --publish 8080:80 \
          --volume /var/run/docker.sock:/tmp/docker.sock:ro \
          jwilder/nginx-proxy:alpine \
          "$@"
    '';
    serviceConfig = {
      ExecStartPre    = "-${pkgs.docker}/bin/docker network create nginx-proxy_net";
      ExecStopPost    = "-${pkgs.docker}/bin/docker rm -f nginx-proxy";
      TimeoutStartSec = 0;
      TimeoutStopSec  = 120;
      Restart         = "always";
    };
  };
}
