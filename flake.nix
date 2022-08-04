{
  description = "The configuration flakes for my personal setup of NixOS";

  inputs = {
    nixpkgs.url          = "github:NixOS/nixpkgs/d9536b9b1e33377fb520e115bc8588d093ed97be";
    dotfiles_flake.url   = "github:placek/dotfiles/master";
    wallpapers_flake.url = "github:placek/wallpapers/master";
    fonts_flake.url      = "github:placek/custom-fonts/master";
  };

  outputs = { self, nixpkgs, dotfiles_flake, wallpapers_flake, fonts_flake, ... }:
    let
      system = "x86_64-linux";
      pkgs   = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.packageOverrides = pkgs: rec {
          slock = pkgs.slock.override { conf = ''
              static const char *user  = "nobody";
              static const char *group = "nogroup";
              static const int failonclear = 1;
              static const char *colorname[NUMCOLS] = { [INIT] = "#32302f", [INPUT] = "#fe8019", [FAILED] = "#fb4934" };
            '';
          };
          custom.dotfiles     = dotfiles_flake.defaultPackage.x86_64-linux;
          custom.wallpapers   = wallpapers_flake.defaultPackage.x86_64-linux;
          custom.custom-fonts = fonts_flake.defaultPackage.x86_64-linux;
          custom.dcc6502      = pkgs.callPackage ./packages/dcc6502 {};
          custom.minipro      = pkgs.callPackage ./packages/minipro {};
          custom.vasm         = pkgs.callPackage ./packages/vasm {};
          custom.gsc          = pkgs.callPackage ./packages/git-shell-commands {};
        };
      };
    in
    {
      nixosConfigurations = {
        omega = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [ ./machines/omega ];
        };

        lambda = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [ ./machines/lambda ];
        };

        alpha = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [ ./machines/alpha ];
        };
      };
    };
}
