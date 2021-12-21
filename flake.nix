{
  description = "The configuration flakes for my personal setup of NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/d235056d6d6dcbd2999bd55fd120d831d4df6304";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      omega = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./machines/omega ];
      };

      lambda = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./machines/lambda ];
      };
    };
  };
}
