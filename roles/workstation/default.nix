{ config, pkgs, ... }:

{
  networking.networkmanager.enable      = true;
  programs.gnupg.agent.enable           = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.gnupg.agent.pinentryFlavor   = "qt";
  programs.ssh.startAgent               = false;
  services.openssh.extraConfig          = "StreamLocalBindUnlink yes";
  services.udisks2.enable               = true;
  sound.enable                          = true;
  virtualisation.docker.autoPrune.dates = "daily";
  virtualisation.docker.enable          = true;
  virtualisation.libvirtd.enable        = true;

  services.acpid.enable = true;

  environment.systemPackages = with pkgs; [
    custom.dcc6502
    custom.minipro
    custom.vasm

    ansible
    avrdude
    cbqn
    croc
    docker-compose
    ffmpeg-full
    ghostscript
    jmespath
    jq
    go-jira
    moc
    neomutt
    ngrok
    niv
    nix-prefetch-git
    orca-c
    pinentry-curses
    playerctl
    rnix-lsp
    rpi-imager
    qmk
    timidity
    tiv
    usbutils
    vagrant
    wally-cli
    wrk2
    youtube-dl

    #pkgsCross.avr.buildPackages.gcc

    (weechat.override {
      configure = { availablePlugins, ... }: {
        plugins = with availablePlugins; [ python perl ];
        scripts = with pkgs.weechatScripts; [ weechat-notify-send wee-slack ];
        init = builtins.readFile ./sources/weechat_config;
      };
    })

    (pass.withExtensions (ext: [ ext.pass-otp ]))
  ];
}
