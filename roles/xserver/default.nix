{ config, pkgs, ... }:

{
  fonts.enableDefaultFonts                = true;
  fonts.fontconfig.defaultFonts.monospace = [ "Iosevka" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Ubuntu" ];
  fonts.fontconfig.defaultFonts.serif     = [ "Ubuntu" ];
  fonts.fonts                             = [ pkgs.iosevka-bin pkgs.ubuntu_font_family ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    wallpapers = pkgs.callPackage ../../packages/wallpapers {};
  };

  services = {
    acpid.enable                                             = true;
    acpid.powerEventCommands                                 = "systemctl start physlock";
    acpid.lidEventCommands                                   = "systemctl start physlock";
    greenclip.enable                                         = true;
    logind.extraConfig                                       = "HandlePowerKey=ignore";
    physlock.enable                                          = true;
    xserver.displayManager.defaultSession                    = "none+xmonad";
    xserver.displayManager.lightdm.enable                    = true;
    xserver.displayManager.lightdm.greeters.mini.enable      = true;
    xserver.displayManager.lightdm.greeters.mini.extraConfig = builtins.readFile ./sources/lightdm_greeters_mini_config;
    xserver.enable                                           = true;
    xserver.layout                                           = "pl";
    xserver.windowManager.xmonad.enable                      = true;
    xserver.windowManager.xmonad.enableContribAndExtras      = true;
    xserver.windowManager.xmonad.extraPackages               = haskellPackages: with haskellPackages; [ alsa-core alsa-mixer xmonad xmonad-contrib xmonad-extras ];
  };

  environment.systemPackages = with pkgs; [
    arandr
    dunst
    feh
    google-chrome-beta
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    kitty
    libnotify
    paper-icon-theme
    pinentry-qt
    qutebrowser
    rofi
    rofi-pass
    scrot
    wallpapers
    xclip
    xdotool
    xmobar
    xmonad-with-packages
    zathura
  ];

  system.userActivationScripts = {
    wallpapers = ''
      rm -rf $HOME/.wall
      ln -s ${pkgs.wallpapers}/shared $HOME/.wall
      true
    '';
  };

  systemd.user.services.dunst = {
    enable = true;
    description = "Shows notifications.";
    wantedBy = [ "default.target" ];
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
  };
}
