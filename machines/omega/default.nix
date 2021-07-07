{ config, lib, pkgs, modulesPath, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
  {
    imports = [
      ../../hardware/usb/backup
      ../../hardware/usb/cdrom
      ../../hardware/usb/secret

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

    #boot.extraModulePackages                            = [ ];
    #boot.initrd.availableKernelModules                  = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    #boot.initrd.kernelModules                           = [ "amdgpu" ];
    #boot.kernelModules                                  = [ "kvm-intel" "i915" ];
    #hardware.cpu.intel.updateMicrocode                  = lib.mkDefault config.hardware.enableRedistributableFirmware;
    #boot.kernelPackages                                 = pkgs.linuxPackages_5_11;
    #boot.kernelParams                                   = [ "acpi_backlight=vendor" "video.use_native_backlight=1" ];
    #boot.loader.efi.canTouchEfiVariables                = true;
    #boot.loader.systemd-boot.enable                     = true;
    #hardware.bluetooth.enable                           = true;
    #hardware.enableRedistributableFirmware              = true;
    #hardware.facetimehd.enable                          = true;
    #hardware.opengl.driSupport                          = true;
    #hardware.opengl.enable                              = true;
    #hardware.opengl.extraPackages                       = with pkgs; [ vaapiIntel vaapiVdpau libvdpau-va-gl intel-media-driver ];
    #hardware.pulseaudio.enable                          = true;
    #hardware.pulseaudio.extraModules                    = [ pkgs.pulseaudio-modules-bt ];
    #hardware.pulseaudio.package                         = pkgs.pulseaudioFull;
    #hardware.video.hidpi.enable                         = lib.mkDefault true;
    #networking.firewall.allowPing                       = false;
    #networking.firewall.allowedTCPPortRanges            = [ { from = 3000; to = 3009; } ];
    #networking.firewall.enable                          = true;
    #networking.hostName                                 = "omega";
    #powerManagement.cpuFreqGovernor                     = lib.mkDefault "performance";
    #programs.light.enable                               = true;
    #services.mbpfan.enable                              = true;
    #services.mbpfan.highTemp                            = 70;
    #services.mbpfan.lowTemp                             = 60;
    #services.mbpfan.maxTemp                             = 80;
    #services.xserver.libinput.enable                    = true;
    #services.xserver.libinput.touchpad.naturalScrolling = true;
    #services.xserver.libinput.touchpad.scrollMethod     = "twofinger";
    #services.xserver.libinput.touchpad.tapping          = false;
    #services.xserver.resolutions                        = [
    #  { x = 1920; y = 1200; }
    #  { x = 1920; y = 1080; }
    #];

    # thinkpad specific - hopefully
    boot.initrd.kernelModules = [ "i915" ];
    boot.kernelModules = [ "acpi_call" ];
    boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.opengl.extraPackages = with pkgs; [ vaapiIntel vaapiVdpau libvdpau-va-gl intel-media-driver ];
    services.throttled.enable = lib.mkDefault true;

    # nvidia
    #services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
    #environment.systemPackages = [ nvidia-offload ];

    #hardware.nvidia.prime = {
    #  offload.enable = lib.mkDefault true;
    #  # Hardware should specify the bus ID for intel/nvidia devices
    #};

    users.users.placek.packages = with pkgs; [
      arduino
      blender
      discord
      eagle
      gimp
      inkscape
      mplayer
      shotwell
      vagrant
    ];
  }
