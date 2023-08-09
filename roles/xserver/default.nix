{ config
, pkgs
, ...
}:
{
  programs.slock.enable = true;

  services = {
    dbus.packages = [ pkgs.gcr ];
    acpid.enable = true;
    greenclip.enable = true;
    logind.extraConfig = "HandlePowerKey=ignore";

    xserver.enable = true;
    xserver.layout = "pl";

    xserver.displayManager.defaultSession = "none+xmonad";
    xserver.displayManager.lightdm.enable = true;
    xserver.displayManager.lightdm.greeters.mini.enable = true;
    xserver.displayManager.lightdm.greeters.mini.extraConfig = builtins.readFile ./sources/lightdm_greeters_mini_config; # TODO: make a attr-set config out of that
    xserver.windowManager.xmonad.enable = true;
  };
}
