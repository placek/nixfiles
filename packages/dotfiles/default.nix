{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "e2e547";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "583fc9b13d6f887019e2403e4741ba0504c1ced5";
    sha256 = "0s264jkxa4shmdrb3294d34l8gg0ik3hv4a3y5mr02s0f79dbrz3";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
