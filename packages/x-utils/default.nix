{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "x-utils-${version}";
  version = "1njzia";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "x-utils";
    rev    = "21ab9642513249bebe8fff50d65151d628499e8e";
    sha256 = "1njziac035274d950db16yczvdz9lxvkh3pjjxpa41md6rjw67lk";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
