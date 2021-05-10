{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "b29a22";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "b29a229d15f04aa3348ffb7b8e0f76a6b275a3c3";
    sha256 = "1f5ik536y3i9bq4f7shba5iabbhqqqy7lcd4jsqgrfdg36akarxj";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
