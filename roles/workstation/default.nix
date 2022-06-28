{ config, pkgs, ... }:

{
  networking.networkmanager.enable      = true;
  programs.gnupg.agent.enable           = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.gnupg.agent.pinentryFlavor   = "qt";
  programs.ssh.startAgent               = false;
  sound.enable                          = true;
  virtualisation.docker.autoPrune.dates = "daily";
  virtualisation.docker.enable          = true;

  # plutus binary cache
  nix = {
    settings.substituters = [ "https://hydra.iohk.io" "https://iohk.cachix.org" ];
    settings.trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo=" ];
  };

  services.acpid.enable = true;

  environment.systemPackages = with pkgs; [
    custom.dcc6502
    custom.minipro
    custom.vasm

    ansible
    avrdude
    docker-compose
    ghostscript
    jmespath
    jq
    moc
    neomutt
    ngrok
    nix-prefetch-git
    orca-c
    pinentry-curses
    tiv
    usbutils
    youtube-dl
    wally-cli
    wrk2

    #pkgsCross.avr.buildPackages.gcc

    (pass.withExtensions (ext: [ ext.pass-otp ]))
  ];
}
