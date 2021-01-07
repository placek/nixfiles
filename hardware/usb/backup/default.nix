{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/backup" = {
    device = "/dev/disk/by-uuid/98f25fdb-c71a-4d60-81e8-3978178fc7c2";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "noauto" ];
  };
}
