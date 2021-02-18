{ config, lib, pkgs, ... }:

{
  imports = [
    ../../roles/common
    ../../roles/nextcloud
    ../../roles/router
    ../../users/placek.nix
    ../../users/git.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable      = true;
  networking.hostName                  = "column";
  services.sshd.enable                 = true;
}
