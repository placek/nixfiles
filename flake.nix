{
  description = "The configuration flakes for my personal setup of NixOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs, ... }:
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
          custom.gsc = pkgs.callPackage ./packages/git-shell-commands {};
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
