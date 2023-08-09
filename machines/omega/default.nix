{ config
, lib
, pkgs
, modulesPath
, ...
}:
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
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
        ../../roles/common
        # ../../roles/entertainment
        ../../roles/workstation
        ../../roles/xserver

        ../../users/placek.nix
      ];

    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

    swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

    boot.extraModulePackages                            = with config.boot.kernelPackages; [ acpi_call ];
    boot.initrd.availableKernelModules                  = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules                           = [ "i915" ];
    boot.kernelModules                                  = [ "acpi_call" "kvm-amd" "kvm-intel" ];
    boot.loader.efi.canTouchEfiVariables                = true;
    boot.loader.systemd-boot.enable                     = true;
    environment.systemPackages                          = [ nvidia-offload ];
    hardware.bluetooth.enable                           = true;
    hardware.cpu.intel.updateMicrocode                  = lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.nvidia.modesetting.enable                  = true;
    hardware.nvidia.nvidiaSettings                      = true;
    hardware.nvidia.open                                = false;
    hardware.nvidia.package                             = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.opengl.driSupport                          = true;
    hardware.opengl.driSupport32Bit                     = true;
    hardware.opengl.enable                              = true;
    hardware.opengl.extraPackages                       = with pkgs; [ vaapiIntel libvdpau-va-gl intel-media-driver ];
    hardware.pulseaudio.enable                          = true;
    hardware.pulseaudio.package                         = pkgs.pulseaudioFull;
    hardware.video.hidpi.enable                         = lib.mkDefault true;
    networking.firewall.allowPing                       = false;
    networking.firewall.allowedTCPPortRanges            = [ { from = 3000; to = 3009; } ];
    networking.firewall.enable                          = true;
    networking.hostName                                 = "omega";
    networking.wlanInterfaces.wlan0                     = { device = "wlp82s0"; mac = "01:00:00:00:00:01"; };
    powerManagement.cpuFreqGovernor                     = lib.mkDefault "performance";
    powerManagement.enable                              = true;
    programs.light.enable                               = true;
    services.throttled.enable                           = lib.mkDefault true;
    services.xserver.libinput.enable                    = true;
    services.xserver.libinput.touchpad.naturalScrolling = true;
    services.xserver.libinput.touchpad.scrollMethod     = "twofinger";
    services.xserver.libinput.touchpad.tapping          = false;
    services.xserver.resolutions                        = [ { x = 1920; y = 1080; } ];
    services.xserver.videoDrivers                       = [ "nvidia" ];
  }
