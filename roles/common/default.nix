{ config, pkgs, ... }:
{
  boot.cleanTmpDir               = true;
  boot.consoleLogLevel           = 0;
  boot.supportedFilesystems      = [ "ntfs" ];
  console.keyMap                 = "pl";
  hardware.keyboard.zsa.enable   = true;
  i18n.defaultLocale             = "pl_PL.UTF-8";
  nix.gc.automatic               = true;
  nix.gc.options                 = "--delete-older-than 7d";
  nix.useSandbox                 = true;
  nixpkgs.config.allowUnfree     = true;
  services.cron.enable           = true;
  services.pcscd.enable          = true;
  services.printing.enable       = true;
  services.printing.drivers      = [ pkgs.foo2zjs ];
  services.udev.packages         = [ pkgs.yubikey-personalization ];
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel     = https://nixos.org/channels/nixos-21.11;
  system.autoUpgrade.enable      = true;
  system.stateVersion            = "21.11";
  time.timeZone                  = "Europe/Warsaw";

  # flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
   };

  programs.tmux = {
    enable           = true;
    aggressiveResize = true;
    baseIndex        = 1;
    clock24          = true;
    escapeTime       = 0;
    keyMode          = "vi";
    terminal         = "xterm-256color";
    extraConfig      = ''
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind a run "tmux split-pane 'projects add'"
      bind-key -n End send Escape "OF"
      bind-key -n Home send Escape "OH"
      set  -g display-time 2000
      set  -g focus-events on
      set  -g mouse on
      set  -g status-interval 5
      set  -g status-left-length 85
      setw -g alternate-screen on
      setw -g monitor-activity off
      set-option -g status-bg "colour0"
      set-option -g status-fg "colour7"
      set-option -g status-left "#[fg=colour7, bg=colour8, bold] #S #[fg=colour8, bg=colour0]"
      set-option -g status-right "#[fg=colour8, bg=colour0]#[fg=colour7, bg=colour8, bold] #H "
      set-window-option -g window-status-current-format "#[fg=colour3, bg=colour0, bold] #I #W "
      set-window-option -g window-status-format " #I #W "
    '';
  };

  nixpkgs.config.packageOverrides = pkgs: rec {
    dotfiles = pkgs.callPackage ../../packages/dotfiles {};
  };

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  environment.systemPackages = with pkgs; [
    aria
    bash
    bat
    bc
    cryptsetup
    universal-ctags
    curl
    direnv
    dotfiles
    ed
    entr
    fd
    ffmpeg-full
    file
    fish
    fzf
    git
    ghc
    gnumake
    imagemagick7
    inxi
    jmtpfs
    lsd
    ncdu
    netpbm
    ngrok
    nix-direnv
    nodejs
    openvpn
    rclone
    ripgrep
    rlwrap
    rsync
    ruby
    stow
    tig
    todoist
    unrar
    unzip
    vifm-full
    wally-cli
    wget

    haskellPackages.haskell-language-server
    haskellPackages.hasktags
    haskellPackages.mustache

    ((vim_configurable.override { python = python3; }).customize {
      name = "vim";
      vimrcConfig.customRC = ''
        filetype plugin indent on
        syntax enable

        set encoding=utf-8
        set exrc
        set hidden
        set hlsearch
        set incsearch
        set nocompatible
        set path+=**
        set secure
        set splitbelow
        set splitright
        set tags+=.git/tags;
        set wildmenu

        source $HOME/.vimrc
      '';
      vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
        opt = [
          coc-fzf
          coc-nvim
          fzf-vim
          fzfWrapper
          haskell-vim
          nerdtree
          tabular
          vim-expand-region
          vim-fugitive
          vim-signature
        ];
      };
    })
  ];
}
