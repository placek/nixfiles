{ config, pkgs, ... }:

{
  networking.networkmanager.enable      = true;
  powerManagement.enable                = true;
  programs.gnupg.agent.enable           = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.ssh.startAgent               = false;
  sound.enable                          = true;
  virtualisation.docker.autoPrune.dates = "daily";
  virtualisation.docker.enable          = true;

  nixpkgs.config.packageOverrides = pkgs: rec {
    dcc6502  = pkgs.callPackage ../../packages/dcc6502 {};
    minipro  = pkgs.callPackage ../../packages/minipro {};
    projects = pkgs.callPackage ../../packages/projects {};
    todo     = pkgs.callPackage ../../packages/todo {};
    vasm     = pkgs.callPackage ../../packages/vasm {};
    x-utils  = pkgs.callPackage ../../packages/x-utils {};
  };

  # plutus binary cache
  nix = {
    binaryCaches          = [ "https://hydra.iohk.io" "https://iohk.cachix.org" ];
    binaryCachePublicKeys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo=" ];
  };

  services.acpid.enable = true;

  environment.systemPackages = with pkgs; [
    avrdude
    dcc6502
    docker-compose
    ghostscript
    google-fonts
    jq
    minipro
    moc
    neomutt
    # pkgsCross.avr.buildPackages.gcc
    projects
    solargraph
    tiv
    todo
    usbutils
    vasm
    x-utils
    youtube-dl

    (pass.withExtensions (ext: [ ext.pass-otp ]))
  ];
}
