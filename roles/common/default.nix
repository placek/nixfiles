{ config, pkgs, ... }:
{
  boot.cleanTmpDir                         = true;
  boot.consoleLogLevel                     = 0;
  boot.supportedFilesystems                = [ "ntfs" ];
  console.keyMap                           = "pl";
  i18n.defaultLocale                       = "pl_PL.UTF-8";
  nix.gc.automatic                         = true;
  nix.gc.options                           = "--delete-older-than 7d";
  nix.useSandbox                           = true;
  nixpkgs.config.allowUnfree               = true;
  services.cron.enable                     = true;
  services.pcscd.enable                    = true;
  services.printing.enable                 = true;
  services.printing.drivers                = [ pkgs.foo2zjs ];
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
    aria
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
    imagemagick7
    inxi
    ncdu
    ngrok
    nodejs
    openvpn
    rclone
    ripgrep
    rsync
    ruby
    sc
    solargraph
    stow
    tig
    tmux
    unrar
    unzip
    vifm-full
    wget

    haskellPackages.haskell-language-server
    haskellPackages.hasktags
    haskellPackages.mustache

    ((vim_configurable.override { python = python3; }).customize {
      name = "vim";
      vimrcConfig.customRC = "source $HOME/.vimrc";
      vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          coc-fzf
          coc-nvim
          coc-snippets
          coc-solargraph
          fzf-vim
          fzfWrapper
          haskell-vim
          nerdtree
          syntastic
          ultisnips
          vim-airline
          vim-airline-themes
          vim-fugitive
        ];
      };
    })
  ];
}
