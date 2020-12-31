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
    projects = pkgs.callPackage ../../packages/projects {};
    todo     = pkgs.callPackage ../../packages/todo {};
  };

  services.acpid.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
    moc
    neomutt
    projects
    todo
    youtube-dl

    (pass.withExtensions (ext: [ ext.pass-otp ]))
    (weechat.override {
      configure = { availablePlugins, ... }: {
        plugins = with availablePlugins; [ python perl ];
        scripts = with pkgs.weechatScripts; [ weechat-notify-send wee-slack ];
        init = builtins.readFile ./sources/weechat_config;
      };
    })
  ];
}
