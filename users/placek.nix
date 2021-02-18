{ config, pkgs, ... }:
let
  secrets = import ../secrets.nix;
  emptyPass = "$6$6894Cw1T54El$zNxGJB3GAVx3Eov8liej2piKg3mcMVrXWeKCYcQJHbruzNDg0HGIGg2Ys6HwxWyABHqIsedSzGdgXY6b.yY1k.";
in
  {
    users.users.placek = {
      description                 = "Paweł Placzyński";
      extraGroups                 = [ "audio" "disk" "docker" "input" "messagebus" "networkmanager" "systemd-journal" "video" "wheel" ];
      isNormalUser                = true;
      shell                       = pkgs.fish;
      uid                         = 1000;
      hashedPassword              = if (builtin.hasAttr "hashedPassword" secrets.placek) then "${secrets.placek.hashedPassword}" else "${emptyPass}";
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrSau4Jlq3xQNiiEMkgETh6bU0/gSlG7ecOFOhzNrcYtcLBQzKNfJrk/59JmXNxXws3u3RBYk1oCe3xnCdeqSTpj4sLJEfXHBuGR4hk2kdk1ve+A0SxL2RKMEGUuA8v0O/0oRykv1EV3oh8HwfYVj0AQzHNxSk1H815gPGNRaq9OTJJgQvUtjNx09dtdY071rNV3D5/ozUqGczdeRbvSlSCHkLZ9mHFGJxd9lbfMV6Bs/XxHrHg+Tc3HDOSmJq7UZeX9i0kvKdyGz9qFdhuIZL4nJWrRjbAMgvMGJJxohtdqgrMv9xuz5UveNVotWBojrMU6n4UcgB1ugUkrDmDL1aBJP6zeRcgk5CtisSMt2eq69LmBEwZDWNHqVQg2Kft32urOH82VfEeZLT+sXD1kWvCFVRcmZtZlENmmkqr0axp9gf4mg1IBkyM7eXjxTg1lDeDw5yFVG/cfbtOUc+twWFJ7nFlC6wVE5prnRW+qI6gpGB4gGZVtzODmIT4OeTXKI2MZPTMn2pwjmx3NM3p8ofZawr3c8TZwCStuWiIvoes3Ps4kt2Z75hoZ+4+LEucUwop0jees0YxrNoFTbwdbfXH0mBCspeSS65CZ96Og2qdE7s1+t3tdZrBWPmgziZIPtvBAmYmzH9JKAX1JgmRirf4tG5sZ2JbA8WDUqSADmadw== cardno:000611879902" ];
    };
    services.xserver.displayManager.lightdm.greeters.mini.user = "placek";
  }
