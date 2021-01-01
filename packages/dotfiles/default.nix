{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "06gr1i";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "ff8dc9f07b938102e726d3603c0f417b321b9e5a";
    sha256 = "06gr1imlr4l1j1bjzwpr05fq1agl8gnjc3ilg48ccvfxhqvg735x";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
