{ config
, pkgs
, ...
}:
{
  boot.consoleLogLevel                  = 0;
  boot.supportedFilesystems             = [ "ntfs" ];
  boot.tmp.cleanOnBoot                  = true;
  console.keyMap                        = "pl";
  hardware.keyboard.zsa.enable          = true;
  i18n.defaultLocale                    = "pl_PL.UTF-8";
  networking.networkmanager.enable      = true;
  nixpkgs.config.allowUnfree            = true;
  security.sudo.wheelNeedsPassword      = false;
  services.cron.enable                  = true;
  services.openssh.extraConfig          = "StreamLocalBindUnlink yes";
  services.printing.drivers             = [ pkgs.foo2zjs ];
  services.printing.enable              = true;
  services.udisks2.enable               = true;
  sound.enable                          = true;
  system.stateVersion                   = "23.11";
  time.timeZone                         = "Europe/Warsaw";
  users.extraGroups.vboxusers.members   = [ "placek" ];
  virtualisation.docker.autoPrune.dates = "daily";
  virtualisation.docker.enable          = true;
  virtualisation.libvirtd.enable        = true;
  virtualisation.virtualbox.host.enable = true;

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
