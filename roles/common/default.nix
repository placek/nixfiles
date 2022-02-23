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

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  environment.systemPackages = with pkgs; [
    custom.dotfiles

    aria
    bash
    bat
    cryptsetup
    curl
    direnv
    entr
    fd
    ffmpeg-full
    file
    fish
    fzf
    git
    imagemagick7
    inxi
    jmtpfs
    lsd
    netpbm
    nix-direnv-flakes
    nodejs
    openssl
    openvpn
    rclone
    ripgrep
    rlwrap
    rsync
    stow
    tig
    universal-ctags
    unrar
    unzip
    vifm-full
    wget
  ];

  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    viAlias       = true;
    vimAlias      = true;
    configure     = {
      customRC = ''
        set runtimepath^=~/.vim
        let &packpath = &runtimepath
        source ~/.vimrc
        luafile ~/.vim/lua/nvim.lua
      '';
      packages.nix = with pkgs.vimPlugins; {
        start = [
          TrueZen-nvim
          cmp-buffer
          cmp-cmdline
          cmp-nvim-lsp
          cmp-path
          cmp-tabnine
          cmp_luasnip
          comment-nvim
          direnv-vim
          friendly-snippets
          gitsigns-nvim
          haskell-vim
          lualine-nvim
          luasnip
          nvim-cmp
          nvim-lspconfig
          tabular
          telescope-fzy-native-nvim
          telescope-nvim
          vim-css-color
          vim-expand-region
          vim-fish
          vim-fugitive
          vim-gruvbox8
          vim-nix
          vim-signature
          vim-surround
          which-key-nvim
        ];
      };
    };
  };

  system.userActivationScripts = {
    dotfiles = ''
      dotfiles_dir=$HOME/.config/dotfiles
      source_dir="${pkgs.custom.dotfiles}/share"
      target_dir=$HOME
      rm -rf $dotfiles_dir
      mkdir $dotfiles_dir
      cp -rv $source_dir/* $dotfiles_dir
      chmod -R +w $dotfiles_dir
      for dir in $(find $source_dir/* -mindepth 1 -type d -printf "%P\n"); do
        mkdir -p  $target_dir/$dir
        chmod 700 $target_dir/$dir
      done
      true
    '';
  };
}
