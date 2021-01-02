{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "6a294c";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "6a294cf62005f75a3fff03f9fd36f15b1a1cdcbd";
    sha256 = "1f16ihn6iwx5bzj05rmfs8vxv2acb7wk79bgdxprvqmlg75pxlzy";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
