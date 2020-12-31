{ config, pkgs, ... }:
{
  users.users.placek = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "messagebus" "systemd-journal" "disk" "audio" "video" "input" ];
    shell = pkgs.fish;
    description = "Paweł Placzyński";
    uid = 1000;
  };
}
