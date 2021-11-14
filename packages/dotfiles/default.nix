{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname   = "dotfiles";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "19c4801e8653f512ead84cf627d6453971d3b2fd";
    sha256 = "1vh8mf9jl9sas59g2mbhqmllz34p5f66dlmb2wy4pgiqpbjgm6ha";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
