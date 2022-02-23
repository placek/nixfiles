{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/hardware/network/broadcom-43xx.nix")
    (modulesPath + "/installer/scan/not-detected.nix")

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

  boot.initrd.availableKernelModules                  = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules                                  = [ "kvm-intel" ];
  hardware.cpu.intel.updateMicrocode                  = lib.mkDefault config.hardware.enableRedistributableFirmware;
  boot.kernelPackages                                 = pkgs.linuxKernel.packages.linux_5_15;
  boot.kernelParams                                   = [ "acpi_backlight=vendor" "video.use_native_backlight=1" ];
  boot.loader.efi.canTouchEfiVariables                = true;
  boot.loader.systemd-boot.enable                     = true;
  hardware.bluetooth.enable                           = true;
  hardware.enableRedistributableFirmware              = true;
  hardware.facetimehd.enable                          = true;
  hardware.opengl.driSupport                          = true;
  hardware.opengl.enable                              = true;
  hardware.opengl.extraPackages                       = with pkgs; [ vaapiIntel ];
  hardware.pulseaudio.enable                          = true;
  hardware.pulseaudio.extraModules                    = [ pkgs.pulseaudio-modules-bt ];
  hardware.pulseaudio.package                         = pkgs.pulseaudioFull;
  hardware.video.hidpi.enable                         = lib.mkDefault false;
  networking.firewall.allowPing                       = false;
  networking.firewall.allowedTCPPortRanges            = [ { from = 3000; to = 3009; } ];
  networking.firewall.enable                          = true;
  networking.hostName                                 = "lambda";
  networking.wlanInterfaces.wlan0                     = { device = "wlp4s0"; mac = "01:00:00:00:00:01"; };
  powerManagement.cpuFreqGovernor                     = "schedutil";
  programs.light.enable                               = true;
  services.mbpfan.enable                              = true;
  services.mbpfan.highTemp                            = 70;
  services.mbpfan.lowTemp                             = 40;
  services.mbpfan.maxTemp                             = 80;
  services.xserver.libinput.enable                    = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.xserver.libinput.touchpad.scrollMethod     = "twofinger";
  services.xserver.libinput.touchpad.tapping          = false;
  services.xserver.resolutions                        = [
    { x = 1920; y = 1200; }
    { x = 1920; y = 1080; }
  ];

  environment.variables = {
    SYMBOL = "λ";
  };
}
