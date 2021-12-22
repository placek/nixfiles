{
  description = "The configuration flakes for my personal setup of NixOS";

  inputs = {
    omega_nixpkgs.url  = "github:NixOS/nixpkgs/9e86f5f7a19db6da2445f07bafa6694b556f9c6d";
    lambda_nixpkgs.url = "github:NixOS/nixpkgs/d235056d6d6dcbd2999bd55fd120d831d4df6304";
  };

  outputs = { self, omega_nixpkgs, lambda_nixpkgs, ... }: {
    nixosConfigurations = {
      omega = omega_nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./machines/omega ];
      };

      lambda = lambda_nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./machines/lambda ];
      };
    };
  };
}
