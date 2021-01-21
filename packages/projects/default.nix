{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "projects-${version}";
  version = "a7da55";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "projects";
    rev    = "a7da55bd10f1d0459893de0fad1a83c2139eeccc";
    sha256 = "0f792djcr2f8bl5mcgh8y4s4cf45q1v100xj1pbp44aiymkcz1ld";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
