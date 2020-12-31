{ config, pkgs, ... }:

{
  systemd.user.services.dotfiles = {
    description = "dotfiles synchronization";
    enable = true;
    serviceConfig = {
      Type            = "oneshot";
      RemainAfterExit = "yes";
      ExecStartPre    = "-${pkgs.dotfiles}/bin/dots install";
      ExecStart       = "${pkgs.dotfiles}/bin/dots mount";
      ExecReload      = "${pkgs.dotfiles}/bin/dots remount";
      ExecStop        = "${pkgs.dotfiles}/bin/dots umount";
    };
    wantedBy = [ "default.target" ];
  };
}
