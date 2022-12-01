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

  # binary cache
  nix = {
    settings.substituters = [ "https://hydra.iohk.io" "https://iohk.cachix.org" "https://cache.iog.io" "https://nixcache.reflex-frp.org" ];
    settings.trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo=" "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
  };

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
