{ config, pkgs, stdenv, lib, ... }:

let
  wine-rome-total-war = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/Wine/rome_tw";
    name   = "rome-total-war";
    cpath  = "Program Files (x86)/The Creative Assembly/Rome - Total War";
    exe    = "RomeTW.exe";
  };

  wine-rome-barbarian-invasion = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/Wine/rome_tw";
    name   = "rome-barbarian-invasion";
    cpath  = "Program Files (x86)/The Creative Assembly/Rome - Total War";
    exe    = "RomeTW-BI.exe";
  };

  wine-rome-alexander = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/Wine/rome_tw";
    name   = "rome-alexander";
    cpath  = "Program Files (x86)/The Creative Assembly/Rome - Total War";
    exe    = "RomeTW-ALX.exe";
  };

  wine-rome-enhancement = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/Wine/rome_tw";
    name   = "rome-enhancement";
    cpath  = "Program Files (x86)/The Creative Assembly/Rome - Total War";
    exe    = "RomeTW-ALX.exe";
    args   = "-show_err -mod:HRTW -noalexander";
  };

  dwarf = import ../../packages/dwarf { inherit pkgs stdenv lib; };
in
  {
    hardware.opengl.driSupport32Bit = true;
    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [
      brogue
      glxinfo
      libretro.mesen
      mesa
      minecraft
      wineWowPackages.stable

      dwarf
      wine-rome-total-war
      wine-rome-barbarian-invasion
      wine-rome-alexander
      wine-rome-enhancement
    ];
  }
