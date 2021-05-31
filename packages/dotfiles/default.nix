{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "8622df";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "8622dfa83baeb58b48c932a552176a1eb0ec5d3b";
    sha256 = "009qdpxq060pnsy2zzj56g7g5isnx4a3kw4bac5429x4ggxsdl2i";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
