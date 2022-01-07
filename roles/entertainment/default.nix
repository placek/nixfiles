{ config, pkgs, ... }:
let
  wine-rome-total-war = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/.wine";
    name   = "rome-total-war";
    cpath  = "Program Files (x86)/The Creative Assembly/Rome - Total War";
    exe    = "RomeTW.exe";
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
    ];
  }
