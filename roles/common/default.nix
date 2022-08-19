{ config, pkgs, ... }:

{
  boot.cleanTmpDir                 = true;
  boot.consoleLogLevel             = 0;
  boot.supportedFilesystems        = [ "ntfs" ];
  console.keyMap                   = "pl";
  hardware.keyboard.zsa.enable     = true;
  i18n.defaultLocale               = "pl_PL.UTF-8";
  nixpkgs.config.allowUnfree       = true;
  services.cron.enable             = true;
  services.pcscd.enable            = true;
  services.printing.enable         = true;
  services.printing.drivers        = [ pkgs.foo2zjs ];
  services.udev.packages           = [ pkgs.yubikey-personalization ];
  security.sudo.wheelNeedsPassword = false;
  system.stateVersion              = "22.05";
  time.timeZone                    = "Europe/Warsaw";

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
    terminal         = "tmux-256color";
    extraConfig      = ''
      run-shell ${pkgs.tmuxPlugins.fingers.rtp}
      run-shell ${pkgs.tmuxPlugins.yank.rtp}

      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind a run "tmux split-pane -vb 'projects add -t'"
      bind-key -T prefix F command-prompt "find-window -Z -- '%%'"
      bind-key -T prefix f run-shell "${pkgs.tmuxPlugins.fingers}/share/tmux-plugins/fingers/scripts/tmux-fingers.sh 'fingers-mode'"

      set -g display-time 2000
      set -g focus-events on
      set -g mouse on
      set -g status-interval 5
      set -g status-left-length 85
      set -g @fingers-keyboard-layout "qwerty-homerow"
      set -g @override_copy_command '${pkgs.xclip}/bin/xclip -i'
      set -g @shell_mode 'vi'
      setw -g alternate-screen on
      setw -g monitor-activity off
      set-option -g status-bg "colour0"
      set-option -g status-fg "colour7"
      set-option -g status-left "#[fg=colour7, bg=colour8, bold] #S #[fg=colour8, bg=colour0]"
      set-option -g status-right "#[fg=colour8, bg=colour0]#[fg=colour7, bg=colour8, bold] #H "
      set-option -sa terminal-overrides ',xterm-256color:RGB'
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
    bind
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
    git-crypt
    htop
    imagemagick7
    inxi
    jmtpfs
    lsd
    netpbm
    ngrep
    nix-direnv-flakes
    nodejs
    openssl
    openvpn
    rclone
    ripgrep
    rlwrap
    rsync
    sshfs
    stow
    tig
    universal-ctags
    unrar
    unzip
    vifm-full
    wget
    zoxide
  ];

  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    viAlias       = true;
    vimAlias      = true;
    configure     = {
      customRC = builtins.readFile ./sources/vim_config;
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
          dressing-nvim
          fidget-nvim
          friendly-snippets
          gitsigns-nvim
          harpoon
          haskell-vim
          lualine-nvim
          luasnip
          nvim-cmp
          nvim-lint
          nvim-lspconfig
          nvim-treesitter
          tabular
          targets-vim
          telescope-file-browser-nvim
          telescope-fzy-native-nvim
          telescope-nvim
          vim-css-color
          vim-expand-region
          vim-fish
          vim-fugitive
          vim-gruvbox8
          vim-jinja
          vim-nix
          vim-signature
          vim-surround
          which-key-nvim
        ];
      };
    };
  };
}
