{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/hardware/network/broadcom-43xx.nix")
    (modulesPath + "/installer/scan/not-detected.nix")

    ../../hardware/usb/backup
    ../../hardware/usb/cdrom
    ../../hardware/usb/polpharma

    ../../roles/common
    ../../roles/entertainment
    ../../roles/workstation
    ../../roles/xserver
    ../../users/placek.nix
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  boot.extraModulePackages                   = [ ];
  boot.initrd.availableKernelModules         = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules                  = [ "amdgpu" ];
  boot.kernelModules                         = [ "kvm-intel" ];
  boot.kernelPackages                        = pkgs.linuxPackages_5_4;
  boot.loader.efi.canTouchEfiVariables       = true;
  boot.loader.systemd-boot.enable            = true;
  hardware.bluetooth.enable                  = true;
  hardware.enableRedistributableFirmware     = true;
  hardware.facetimehd.enable                 = true;
  hardware.opengl.driSupport                 = true;
  hardware.opengl.enable                     = true;
  hardware.opengl.extraPackages              = [ pkgs.vaapiIntel ];
  hardware.pulseaudio.enable                 = true;
  hardware.pulseaudio.extraModules           = [ pkgs.pulseaudio-modules-bt ];
  hardware.pulseaudio.package                = pkgs.pulseaudioFull;
  hardware.video.hidpi.enable                = lib.mkDefault true;
  networking.hostName                        = "lambda";
  powerManagement.cpuFreqGovernor            = lib.mkDefault "powersave";
  programs.light.enable                      = true;
  services.mbpfan.enable                     = true;
  services.mbpfan.highTemp                   = 64;
  services.mbpfan.lowTemp                    = 61;
  services.mbpfan.maxTemp                    = 84;
  services.xserver.libinput.enable           = true;
  services.xserver.libinput.naturalScrolling = true;
  services.xserver.libinput.scrollMethod     = "twofinger";
  services.xserver.libinput.tapping          = false;

  users.users.placek.packages = with pkgs; [
    blender
    fusuma
    gimp
    inkscape
    libreoffice-fresh
    mplayer
    shotwell
  ];
}
