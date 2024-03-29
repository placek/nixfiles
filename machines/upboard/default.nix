{ config, lib, pkgs, ... }:

{
  imports = [
    ../roles/common
    ../roles/workstation
    ../roles/xserver
    ../../users/placek.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable      = true;
  networking.hostName                  = "upboard";
  # users.users.placek.packages          = with pkgs; [ arduino blender eagle gimp inkscape libreoffice-fresh mplayer musescore shotwell virtualbox vnstat ];
}
