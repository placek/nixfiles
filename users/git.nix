{ config, pkgs, ... }:
let
  repos-dir = "/var/git";
  repos     = import ../packages/git-shell-tools { inherit pkgs repos-dir; };
in
  {
    users.users.git = {
      description                 = "GIT entrypoint";
      createHome                  = true;
      extraGroups                 = [ "docker" ];
      home                        = "${repos-dir}";
      isNormalUser                = true;
      shell                       = "${pkgs.git}/bin/git-shell";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrSau4Jlq3xQNiiEMkgETh6bU0/gSlG7ecOFOhzNrcYtcLBQzKNfJrk/59JmXNxXws3u3RBYk1oCe3xnCdeqSTpj4sLJEfXHBuGR4hk2kdk1ve+A0SxL2RKMEGUuA8v0O/0oRykv1EV3oh8HwfYVj0AQzHNxSk1H815gPGNRaq9OTJJgQvUtjNx09dtdY071rNV3D5/ozUqGczdeRbvSlSCHkLZ9mHFGJxd9lbfMV6Bs/XxHrHg+Tc3HDOSmJq7UZeX9i0kvKdyGz9qFdhuIZL4nJWrRjbAMgvMGJJxohtdqgrMv9xuz5UveNVotWBojrMU6n4UcgB1ugUkrDmDL1aBJP6zeRcgk5CtisSMt2eq69LmBEwZDWNHqVQg2Kft32urOH82VfEeZLT+sXD1kWvCFVRcmZtZlENmmkqr0axp9gf4mg1IBkyM7eXjxTg1lDeDw5yFVG/cfbtOUc+twWFJ7nFlC6wVE5prnRW+qI6gpGB4gGZVtzODmIT4OeTXKI2MZPTMn2pwjmx3NM3p8ofZawr3c8TZwCStuWiIvoes3Ps4kt2Z75hoZ+4+LEucUwop0jees0YxrNoFTbwdbfXH0mBCspeSS65CZ96Og2qdE7s1+t3tdZrBWPmgziZIPtvBAmYmzH9JKAX1JgmRirf4tG5sZ2JbA8WDUqSADmadw== cardno:000611879902"
      ];
    };

    environment.systemPackages = with pkgs; [
      git
      docker-compose
      repos.repos-create
      repos.repos-delete
      repos.repos-list
      repos.ci-list
      repos.ci-show
      repos.ci-run
    ];
  }
