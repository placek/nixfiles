{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/secret1" = {
    # to open disk:
    #   sudo cryptsetup open /dev/disk/by-uuid/e2948dc0-c2ff-4425-bc1b-27dd2ac6674a secret
    #   mount /mnt/secret1
    # to close disk:
    #   umount /mnt/secret1
    #   sudo cryptsetup close secret
    device = "/dev/mapper/secret";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "noauto" ];
  };
  fileSystems."/mnt/secret2" = {
    device = "/dev/disk/by-uuid/da34b822-6352-4eb3-9db5-f8418342e597";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "noauto" ];
  };
}
