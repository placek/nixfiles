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
    minipro  = pkgs.callPackage ../../packages/minipro {};
    projects = pkgs.callPackage ../../packages/projects {};
    todo     = pkgs.callPackage ../../packages/todo {};
    vasm     = pkgs.callPackage ../../packages/vasm {};
    x-utils  = pkgs.callPackage ../../packages/x-utils {};
  };

  services.acpid.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
    minipro
    moc
    neomutt
    projects
    tiv
    todo
    vasm
    x-utils
    youtube-dl

    (pass.withExtensions (ext: [ ext.pass-otp ]))
  ];
}
