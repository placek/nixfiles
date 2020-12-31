{ config, pkgs, ... }:

{
  fonts.enableDefaultFonts                = true;
  fonts.fontconfig.defaultFonts.monospace = [ "Iosevka" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Ubuntu" ];
  fonts.fontconfig.defaultFonts.serif     = [ "Ubuntu" ];
  fonts.fonts                             = [ pkgs.iosevka-bin pkgs.ubuntu_font_family ];
  security.wrappers.slock.source          = "${pkgs.slock.out}/bin/slock";

  nixpkgs.config.packageOverrides = pkgs: rec {
    wallpapers = pkgs.callPackage ../../packages/wallpapers {};
  };

  services = {
    greenclip.enable = true;
    xserver = {
      displayManager.defaultSession = "none+xmonad";
      displayManager.lightdm = {
        enable = true;
        greeters.mini.enable = true;
        greeters.mini.extraConfig = builtins.readFile ./sources/lightdm_greeters_mini_config;
      };
      enable = true;
      layout = "pl";
      windowManager.xmonad = {
        enableContribAndExtras = true;
        haskellPackages = pkgs.haskell.packages.ghc865;
        extraPackages = haskellPackages: with haskellPackages; [
          alsa-core
          alsa-mixer
          xmonad
          xmonad-contrib
          xmonad-extras
        ];
        enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    arandr
    chromium
    dunst
    feh
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    libnotify
    paper-icon-theme
    pinentry-qt
    qutebrowser
    rofi
    rofi-pass
    scrot
    slock
    sxiv
    termite
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
}
