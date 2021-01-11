{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "5e9d6c";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "5e9d6c30165dd3c59d7b65afe521e2da9a56d80d";
    sha256 = "1a8wbcn552lkq7x65ssd7kf9y054rhqhf22jxbf1w960wjskgwl6";
  };

  buildInputs = [ pkgs.haskellPackages.mustache ];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
