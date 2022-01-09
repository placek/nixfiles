{ config, pkgs, ... }:
let
  wine-rome-total-war = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/.wine";
    name   = "rome-total-war";
    cpath  = "Program Files (x86)/The Creative Assembly/Rome - Total War";
    exe    = "RomeTW.exe";
  };

  wine-rome-barbarian-invasion = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/.wine";
    name   = "rome-barbarian-invasion";
    cpath  = "Program Files (x86)/The Creative Assembly/Rome - Total War";
    exe    = "RomeTW-BI.exe";
  };

  wine-rome-alexander = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/.wine";
    name   = "rome-alexander";
    cpath  = "Program Files (x86)/The Creative Assembly/Rome - Total War";
    exe    = "RomeTW-ALX.exe";
  };
in
{
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = with pkgs; [
    glxinfo
    libretro.mesen
    mesa
    wineWowPackages.stable

    wine-rome-total-war
    wine-rome-barbarian-invasion
    wine-rome-alexander
  ];
}
