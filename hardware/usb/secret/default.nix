{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/secret1" = {
    # to open disk:
    #   sudo cryptsetup open /dev/disk/by-uuid/19b73b1a-c557-4981-aeb9-832bd0a02268 secret
    #   mount /mnt/private1
    # to close disk:
    #   umount /mnt/private1
    #   sudo cryptsetup close secret
    device = "/dev/mapper/secret";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "noauto" ];
  };
  fileSystems."/mnt/secret2" = {
    device = "/dev/disk/by-uuid/5a43262d-2451-4302-9b40-b359e4162dcb";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "noauto" ];
  };
}
