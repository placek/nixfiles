{
  description = "The configuration flakes for my personal setup of NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/9e86f5f7a19db6da2445f07bafa6694b556f9c6d";
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
