{
  description = "The configuration flakes for my personal setup of NixOS";

  inputs = {
    omega_nixpkgs.url    = "github:NixOS/nixpkgs/9e86f5f7a19db6da2445f07bafa6694b556f9c6d";
    lambda_nixpkgs.url   = "github:NixOS/nixpkgs/d235056d6d6dcbd2999bd55fd120d831d4df6304";
    dotfiles_flake.url   = "github:placek/dotfiles/master";
    wallpapers_flake.url = "github:placek/wallpapers/master";
    fonts_flake.url      = "github:placek/custom-fonts/master";
  };

  outputs = { self, omega_nixpkgs, lambda_nixpkgs, dotfiles_flake, wallpapers_flake, fonts_flake, ... }:
    let
      system = "x86_64-linux";
      pkgs   = import omega_nixpkgs {
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
        omega = omega_nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [ ./machines/omega ];
        };

        lambda = lambda_nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [ ./machines/lambda ];
        };
      };
    };
}
