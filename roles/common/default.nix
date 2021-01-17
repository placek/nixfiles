{ config, pkgs, ... }:
{
  boot.cleanTmpDir                         = true;
  boot.supportedFilesystems                = [ "ntfs" ];
  console.keyMap                           = "pl";
  i18n.defaultLocale                       = "pl_PL.UTF-8";
  networking.firewall.allowPing            = false;
  networking.firewall.allowedTCPPortRanges = [ { from = 3000; to = 3009; } ];
  networking.firewall.enable               = true;
  nix.gc.automatic                         = true;
  nix.gc.options                           = "--delete-older-than 7d";
  nix.useSandbox                           = true;
  nixpkgs.config.allowUnfree               = true;
  services.cron.enable                     = true;
  services.pcscd.enable                    = true;
  services.printing.enable                 = true;
  services.udev.packages                   = [ pkgs.yubikey-personalization ];
  system.autoUpgrade.allowReboot           = true;
  system.autoUpgrade.channel               = https://nixos.org/channels/nixos-20.09;
  system.autoUpgrade.enable                = true;
  system.stateVersion                      = "21.03";
  time.timeZone                            = "Europe/Warsaw";

  nixpkgs.config.packageOverrides = pkgs: rec {
    dotfiles = pkgs.callPackage ../../packages/dotfiles {};
    sc       = pkgs.callPackage ../../packages/sc {};
  };

  environment.systemPackages = with pkgs; [
    bash
    bat
    bc
    cryptsetup
    ctags
    curl
    dotfiles
    ed
    entr
    fd
    ffmpeg
    file
    fish
    fzf
    git
    gnumake
    haskellPackages.mustache
    imagemagick7
    inxi
    ncdu
    ngrok
    openvpn
    pinentry-curses
    rclone
    rsync
    sc
    silver-searcher
    stow
    tig
    tiv
    tmux
    unrar
    unzip
    vifm-full
    wget

    ((vim_configurable.override { python = python3; }).customize {
      name = "vim";
      vimrcConfig.customRC = "source $HOME/.vimrc";
      vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          YouCompleteMe
          fzf-vim
          fzfWrapper
          nerdtree
          syntastic
          tabular
          ultisnips
          vim-airline
          vim-airline-themes
          vim-fugitive
          vim-gitgutter
        ];
      };
    })
  ];
}
