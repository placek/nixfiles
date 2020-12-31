{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "14hq4z";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "26e879a6816575ce3bf16bb402555c25e0a20b58";
    sha256 = "14hq4zc4g4v31hx82k3hv10sgjjr5z2xl0d2x8nqpm77rfzf0qi0";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
