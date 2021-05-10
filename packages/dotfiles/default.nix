{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "831531";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "831531c6385e5db3a255a0e43c5eac9c4aff03c9";
    sha256 = "1wdb0r22dh4739c5d3w0jivj1d2hq8jwd5n11f9cmc7fb4p6pamp";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
