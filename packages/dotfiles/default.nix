{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "a14dd7";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "a14dd73eb58a9f69d1c1f3d7bcbe6693cfd87260";
    sha256 = "1hnrdc93iqfaczg882z3w9g09j762mgga92m86gsgpi03mg9f9ga";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
