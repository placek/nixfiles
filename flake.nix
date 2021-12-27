{
  description = "The configuration flakes for my personal setup of NixOS";

  inputs = {
    nixpkgs.url          = "github:NixOS/nixpkgs/d887ac7aee92e8fc54dde9060d60d927afae9d69";
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
          custom.dotfiles     = dotfiles_flake.defaultPackage.x86_64-linux;
          custom.wallpapers   = wallpapers_flake.defaultPackage.x86_64-linux;
          custom.custom-fonts = fonts_flake.defaultPackage.x86_64-linux;
          custom.dcc6502      = pkgs.callPackage ./packages/dcc6502 {};
          custom.minipro      = pkgs.callPackage ./packages/minipro {};
          custom.vasm         = pkgs.callPackage ./packages/vasm {};
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
      };
    };
}
