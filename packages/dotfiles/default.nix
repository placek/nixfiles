{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "67ed51";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "67ed51385621cf35fc036bb2d243c70de3d2b2f6";
    sha256 = "0lpv3k2pjxrbg9h2s2s8jkycvak59y8d5l1sw2b25ds19ckkz6cv";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
