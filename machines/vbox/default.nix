{ config, lib, pkgs, ... }:

{
  imports = [
    ../roles/common
    ../roles/workstation
    ../../users/placek.nix
  ];

  boot.loader.grub = {
    enable  = true;
    version = 2;
    device  = "/dev/sda";
  };
  networking.hostName = "vbox";
}
