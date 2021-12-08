{ config, pkgs, ... }:

{
  networking.networkmanager.enable      = true;
  powerManagement.enable                = true;
  programs.gnupg.agent.enable           = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.gnupg.agent.pinentryFlavor   = "qt";
  programs.ssh.startAgent               = false;
  sound.enable                          = true;
  virtualisation.docker.autoPrune.dates = "daily";
  virtualisation.docker.enable          = true;

  nixpkgs.config.packageOverrides = pkgs: rec {
    cbqn     = pkgs.callPackage ../../packages/cbqn {};
    dcc6502  = pkgs.callPackage ../../packages/dcc6502 {};
    minipro  = pkgs.callPackage ../../packages/minipro {};
    vasm     = pkgs.callPackage ../../packages/vasm {};
  };

  # plutus binary cache
  nix = {
    binaryCaches          = [ "https://hydra.iohk.io" "https://iohk.cachix.org" ];
    binaryCachePublicKeys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo=" ];
  };

  services.acpid.enable = true;

  environment.systemPackages = with pkgs; [
    avrdude
    cbqn
    dcc6502
    docker-compose
    ghostscript
    jq
    minipro
    moc
    neomutt
    nix-prefetch-git
    orca-c
    #pkgsCross.avr.buildPackages.gcc
    pinentry-curses
    tiv
    usbutils
    vasm
    youtube-dl

    (pass.withExtensions (ext: [ ext.pass-otp ]))
  ];
}
