{ config, pkgs, ... }:

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
in
{
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = with pkgs; [
    #steam
    brogue
    glxinfo
    libretro.mesen
    mesa
    minecraft
    wineWowPackages.stable

    (dwarf-fortress-packages.dwarf-fortress-full.override {
      dfVersion            = "0.47.05";
      enableIntro          = false;
      enableSound          = false;
      enableDFHack         = false;
      enableTWBT           = false;
      enableStoneSense     = false;
      enableDwarfTherapist = false;
      enableLegendsBrowser = false;
      enableTruetype       = false;
      enableFPS            = false;
      enableTextMode       = true;
      theme                = null;
    })

    wine-rome-total-war
    wine-rome-barbarian-invasion
    wine-rome-alexander
  ];
}
