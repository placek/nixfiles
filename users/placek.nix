{ config, pkgs, ... }:

{
  users.users.placek = {
    description                 = "Paweł Placzyński";
    extraGroups                 = [ "audio" "disk" "docker" "input" "messagebus" "networkmanager" "plugdev" "systemd-journal" "video" "wheel" ];
    isNormalUser                = true;
    shell                       = pkgs.fish;
    uid                         = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrSau4Jlq3xQNiiEMkgETh6bU0/gSlG7ecOFOhzNrcYtcLBQzKNfJrk/59JmXNxXws3u3RBYk1oCe3xnCdeqSTpj4sLJEfXHBuGR4hk2kdk1ve+A0SxL2RKMEGUuA8v0O/0oRykv1EV3oh8HwfYVj0AQzHNxSk1H815gPGNRaq9OTJJgQvUtjNx09dtdY071rNV3D5/ozUqGczdeRbvSlSCHkLZ9mHFGJxd9lbfMV6Bs/XxHrHg+Tc3HDOSmJq7UZeX9i0kvKdyGz9qFdhuIZL4nJWrRjbAMgvMGJJxohtdqgrMv9xuz5UveNVotWBojrMU6n4UcgB1ugUkrDmDL1aBJP6zeRcgk5CtisSMt2eq69LmBEwZDWNHqVQg2Kft32urOH82VfEeZLT+sXD1kWvCFVRcmZtZlENmmkqr0axp9gf4mg1IBkyM7eXjxTg1lDeDw5yFVG/cfbtOUc+twWFJ7nFlC6wVE5prnRW+qI6gpGB4gGZVtzODmIT4OeTXKI2MZPTMn2pwjmx3NM3p8ofZawr3c8TZwCStuWiIvoes3Ps4kt2Z75hoZ+4+LEucUwop0jees0YxrNoFTbwdbfXH0mBCspeSS65CZ96Og2qdE7s1+t3tdZrBWPmgziZIPtvBAmYmzH9JKAX1JgmRirf4tG5sZ2JbA8WDUqSADmadw== cardno:000611879902"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDj6cAM1kBtxfMUkWmKP3v+EDpWPpGpySRXrog1i//fLJK9oFuyIT6ZDL3aeO17fISdLzvykWAHlj7QEoJ25UPhiDhwND3SMWokyUPbbTleVrtz6ntExEvfD2wGpLFPSJiLMKPnzzV2fk92mEHo8AGTkIEow4W7IYA72IfJ2by9QNVgXgs7GIyRmiHhtWsYg2vSDXhRsuM3QQrzLyAqQs7FKBIqKDWDA0ckP7t5V+QIHv8WHSzFG4Wpisbscf971nQpsz6BwPcdrhToGD8Dza5aDXDB7xy8fdeNp20N84yF0kEX20eXuq19XYcUcNsuiwK1pVYadMPNPan06MWGcdwWEHSjTMpU3HQgE2XkKXE2jj+ArdbF9b1HGQhFTQ7HJ3XooxStHgxKHHGCWkYxTKFJXZ6TOedQ9wuvqCtrFoq1Tm+fmnpVdA62Acw4hF1Deqiyh2tPbloCNuBMEsgo7R81Hmu4Rf/pMsL5m0lA6Wo2wll82HkzEXuC7y4+GMdEBzZazy24Fy+jVoiik4gwuhPaRrB9ZAso+SXr2vaj/hzUMGGcfvjpzArbxOnKYuZFrhQHZwT1bN7QGWOAMTR9CgKn20oAdr2+Hejo3X/t/23e2JRH1wEsB/ajo0QBLJwSjvzmOilfyVlQPwsVPpKruVbLHvCTQ34i8vknqRU8zmYaVw== JuiceSSH"
    ];
  };
  services.xserver.displayManager.lightdm.greeters.mini.user = "placek";
}
