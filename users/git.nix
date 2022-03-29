{ config, pkgs, ... }:

{
  users.users.git = {
    description                 = "GIT entrypoint";
    createHome                  = true;
    extraGroups                 = [ "docker" ];
    home                        = "/var/git";
    isNormalUser                = true;
    shell                       = "${pkgs.git}/bin/git-shell";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrSau4Jlq3xQNiiEMkgETh6bU0/gSlG7ecOFOhzNrcYtcLBQzKNfJrk/59JmXNxXws3u3RBYk1oCe3xnCdeqSTpj4sLJEfXHBuGR4hk2kdk1ve+A0SxL2RKMEGUuA8v0O/0oRykv1EV3oh8HwfYVj0AQzHNxSk1H815gPGNRaq9OTJJgQvUtjNx09dtdY071rNV3D5/ozUqGczdeRbvSlSCHkLZ9mHFGJxd9lbfMV6Bs/XxHrHg+Tc3HDOSmJq7UZeX9i0kvKdyGz9qFdhuIZL4nJWrRjbAMgvMGJJxohtdqgrMv9xuz5UveNVotWBojrMU6n4UcgB1ugUkrDmDL1aBJP6zeRcgk5CtisSMt2eq69LmBEwZDWNHqVQg2Kft32urOH82VfEeZLT+sXD1kWvCFVRcmZtZlENmmkqr0axp9gf4mg1IBkyM7eXjxTg1lDeDw5yFVG/cfbtOUc+twWFJ7nFlC6wVE5prnRW+qI6gpGB4gGZVtzODmIT4OeTXKI2MZPTMn2pwjmx3NM3p8ofZawr3c8TZwCStuWiIvoes3Ps4kt2Z75hoZ+4+LEucUwop0jees0YxrNoFTbwdbfXH0mBCspeSS65CZ96Og2qdE7s1+t3tdZrBWPmgziZIPtvBAmYmzH9JKAX1JgmRirf4tG5sZ2JbA8WDUqSADmadw== cardno:000611879902"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnk1lZsCKbIndXO5JxqIWlKOj4l90lPf1Wg+/DdDy0sqn+Jn3JUy7sbfx9BFS5WYGi2ok+Oo0vDyL+B6T3DHr+R8mZgErdZXiSBIrpZuU9V1l2lyK4whnmBLu95q2hUFqiANsj3B5wn1dyb6Wr27Zjr8AkugLj+ISKQHoCazrHxXQyR8/Kmj45nG2MzDAEfFxe60U8qbMrm2/SdQcWp19FLchfah9ULO81C4Uzj1uBy9H1Zt/Haw00vv2sBVrNLQBMPSDrnFQsVH6zS+INp9RHTWCWz/CM4zGN2GcoO1npRs0kfEsZlF1TGb6HzWAi0f61MkC7Sc0C5KqvYGIXpYN9rw4S0z74EeblCdfl0zIBXQby8o7Fs3fU/PjgcfPgzXgtHmigblS6q4oPRE930DltuC04hkV0XGzKWzidiPmZcYQbUCexpLknFBmCUpw+O3cC4UjVsSUg+TcjOulEQYKlSf1/fG8Kg+H1elBWsikHnWY4XZPZSsu1F92Y9FjH9JTT9yrDjDZYm+nmOLsrIOsdemyXR9GuF6z0YNJZBIMiyRrIWqiRxno6axPAqJ5inaddyjm0DaU9PMAp2gKGZB+Enr4fiC6g26szLcK+jMRpGOQtRu4v/cS4Cgmv19U9bu32crPtj2bE7LpkAvcejPAZxCHTyZVTn4+lTHiq6jvojQ== placek@column"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    docker-compose
    custom.gsc
  ];
}
