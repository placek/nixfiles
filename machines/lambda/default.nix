{ config, lib, pkgs, ... }:

{
  imports = [
    ../../hardware/usb/backup
    ../../hardware/usb/cdrom
    ../../hardware/usb/polpharma

    ../../roles/common
    ../../roles/entertainment
    ../../roles/workstation
    ../../roles/xserver
    ../../users/placek.nix
  ];

  boot.initrd.kernelModules                  = [ "amdgpu" ];
  boot.kernelPackages                        = pkgs.linuxPackages_5_4;
  boot.loader.efi.canTouchEfiVariables       = true;
  boot.loader.systemd-boot.enable            = true;
  hardware.bluetooth.enable                  = true;
  hardware.enableRedistributableFirmware     = true;
  hardware.facetimehd.enable                 = true;
  hardware.opengl.driSupport                 = true;
  hardware.opengl.enable                     = true;
  hardware.opengl.extraPackages              = [ pkgs.vaapiIntel ];
  hardware.pulseaudio.enable                 = true;
  hardware.pulseaudio.extraModules           = [ pkgs.pulseaudio-modules-bt ];
  hardware.pulseaudio.package                = pkgs.pulseaudioFull;
  networking.hostName                        = "lambda";
  programs.light.enable                      = true;
  services.mbpfan.enable                     = true;
  services.mbpfan.highTemp                   = 64;
  services.mbpfan.lowTemp                    = 61;
  services.mbpfan.maxTemp                    = 84;
  services.xserver.libinput.enable           = true;
  services.xserver.libinput.naturalScrolling = true;
  services.xserver.libinput.scrollMethod     = "twofinger";
  services.xserver.libinput.tapping          = false;

  users.users.placek.packages = with pkgs; [
    blender
    fusuma
    gimp
    inkscape
    libreoffice-fresh
    mplayer
    shotwell
  ];
}
