{ config, pkgs, ... }:

{
  fonts.enableDefaultFonts                = true;
  fonts.fontconfig.defaultFonts.monospace = [ "Iosevka" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Ubuntu" ];
  fonts.fontconfig.defaultFonts.serif     = [ "Ubuntu" ];
  fonts.fonts                             = [ pkgs.iosevka-bin pkgs.ubuntu_font_family ];
  networking.networkmanager.enable        = true;
  powerManagement.enable                  = true;
  programs.gnupg.agent.enable             = true;
  programs.gnupg.agent.enableSSHSupport   = true;
  programs.ssh.startAgent                 = false;
  security.wrappers.slock.source          = "${pkgs.slock.out}/bin/slock";
  sound.enable                            = true;
  virtualisation.docker.autoPrune.dates   = "daily";
  virtualisation.docker.enable            = true;

  nixpkgs.config.packageOverrides = pkgs: rec {
    projects   = pkgs.callPackage ../../packages/projects {};
    todo       = pkgs.callPackage ../../packages/todo {};
    wallpapers = pkgs.callPackage ../../packages/wallpapers {};
  };

  services = {
    acpid.enable = true;
    greenclip.enable = true;
    xserver = {
      displayManager.defaultSession = "none+xmonad";
      displayManager.lightdm = {
        enable = true;
        greeters.mini.enable = true;
        greeters.mini.user = "placek";
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
    docker-compose
    moc
    neomutt
    projects
    todo
    youtube-dl

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

    (pass.withExtensions (ext: [ ext.pass-otp ]))
    (weechat.override {
      configure = { availablePlugins, ... }: {
        plugins = with availablePlugins; [ python perl ];
        scripts = with pkgs.weechatScripts; [ weechat-notify-send wee-slack ];
        init = builtins.readFile ./sources/weechat_config;
      };
    })
  ];

  system.userActivationScripts = {
    wallpapers = ''
      rm -rf $HOME/.wall
      ln -s ${pkgs.wallpapers}/shared $HOME/.wall
      true
    '';
  };
}
