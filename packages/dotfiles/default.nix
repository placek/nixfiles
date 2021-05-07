{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "2c01e8";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "2c01e821a92b90bbec37e9bad72a72476290fbd3";
    sha256 = "10jrrhgkwxndlsfhpv4k2hn7w4ar8kzkpm8g6hdhrp14h4z1jkx6";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
