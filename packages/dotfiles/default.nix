{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname   = "dotfiles";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "ccf94af11ee781223c15b7f6ee3033f8dbfaca23";
    sha256 = "1khvsczyq9jlz6pv5xf8r63yjmnqgzal05fl0dddzlc35qmrgzal";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
