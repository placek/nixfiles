{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
  [ (modulesPath + "/installer/scan/not-detected.nix")
    ../../roles/common
    ../../roles/entertainment
    ../../roles/router
    ../../roles/workstation
    ../../roles/xserver

    ../../users/placek.nix
    ../../users/git.nix
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/237272ac-0641-4aa6-ae72-a63231013c5f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CE51-4F70";
    fsType = "vfat";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/81e522a7-460b-4202-a8a1-e27c87eb4ee2"; } ];

  boot.extraModulePackages             = [ ];
  boot.initrd.availableKernelModules   = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.kernelModules                   = [ "kvm-amd" "kvm-intel" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable      = true;
  hardware.bluetooth.enable            = true;
  hardware.cpu.intel.updateMicrocode   = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.opengl.driSupport           = true;
  hardware.opengl.enable               = true;
  hardware.pulseaudio.enable           = true;
  hardware.pulseaudio.package          = pkgs.pulseaudioFull;
  hardware.video.hidpi.enable          = lib.mkDefault true;
  networking.hostName                  = "alpha";
  services.sshd.enable                 = true;
  services.xserver.resolutions         = [ { x = 1920; y = 1080; } ];
  systemd.targets.hibernate.enable     = false;
  systemd.targets.hybrid-sleep.enable  = false;
  systemd.targets.sleep.enable         = false;
  systemd.targets.suspend.enable       = false;

  hardware.enableAllFirmware = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.extraConfig = ''
    load-module module-bluetooth-policy auto_switch=2
  '';

  environment.variables = {
    SYMBOL = "α";
  };

  system.userActivationScripts = {
    dotfiles = import ../../packages/dotfilesScript { pkgs = pkgs; mobile = false; };
  };
}
