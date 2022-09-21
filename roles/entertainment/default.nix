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

  heroes = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/Wine/homm3";
    name   = "heroes3";
    cpath  = "Program Files (x86)/GOG.com/Heroes of Might and Magic 3 Complete";
    exe    = "Heroes3.exe";
  };

  gothic = import ../../packages/run-in-wine {
    inherit pkgs;
    prefix = "$HOME/Wine/gothic";
    name   = "gothic";
    cpath  = "Program Files (x86)/Piranha Bytes/Gothic/System";
    exe    = "GOTHIC.EXE";
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
      gothic
      heroes
      wine-rome-total-war
      wine-rome-barbarian-invasion
      wine-rome-alexander
      wine-rome-enhancement
    ];
  }
