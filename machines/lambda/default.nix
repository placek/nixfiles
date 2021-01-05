{ config, lib, pkgs, ... }:

{
  imports = [
    ../../roles/common
    ../../roles/workstation
    ../../roles/xserver
    ../../users/placek.nix
  ];

  boot.loader.efi.canTouchEfiVariables       = true;
  boot.loader.systemd-boot.enable            = true;
  boot.initrd.kernelModules                  = [ "amdgpu" ];
  hardware.bluetooth.enable                  = true;
  hardware.facetimehd.enable                 = true;
  hardware.opengl.extraPackages              = [ pkgs.vaapiIntel ];
  hardware.pulseaudio.enable                 = true;
  networking.hostName                        = "lambda";
  programs.light.enable                      = true;
  services.xserver.libinput.enable           = true;
  services.xserver.libinput.naturalScrolling = true;
  services.xserver.libinput.scrollMethod     = "twofinger";
  services.xserver.libinput.tapping          = false;
  services.mbpfan.enable                     = true;
  services.mbpfan.lowTemp                    = 61;
  services.mbpfan.highTemp                   = 64;
  services.mbpfan.maxTemp                    = 84;

  users.users.placek.packages = with pkgs; [
    arduino
    blender
    eagle
    fusuma
    gimp
    inkscape
    libreoffice-fresh
    mplayer
    musescore
    shotwell
    virtualbox
    vnstat
  ];
}
