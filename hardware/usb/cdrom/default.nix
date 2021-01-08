{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/cdrom" = {
    device = "/dev/sr0";
    fsType = "auto";
    options = [ "defaults" "user" "noauto" ];
  };
}
