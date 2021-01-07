{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/private1" = {
    device = "/dev/mapper/private"; # sudo cryptsetup open /dev/disk/by-uuid/08f38e3f-b9ae-48cb-a6e4-47c063e42285 private
    fsType = "auto";
    options = [ "defaults" "user" "rw" "noauto" ];
  };
  fileSystems."/mnt/private2" = {
    device = "/dev/disk/by-uuid/6b869aaa-6c6c-40dd-821d-af005c695903";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "noauto" ];
  };
  fileSystems."/mnt/private3" = {
    device = "/dev/disk/by-uuid/9E0C-009C";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "noauto" ];
  };
}
