{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname   = "wallpapers";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitLab {
    owner  = "dwt1";
    repo   = "wallpapers";
    rev    = "a341d5b24ef8abbd71b44a0dacecdb301fb78eea";
    sha256 = "1bd35dkhwzw3xjbbx9ignnr81wy841krk8cqxnjqsc4sgi9ic360";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out/shared
    cp -r *.jpg $out/shared
  '';
}
