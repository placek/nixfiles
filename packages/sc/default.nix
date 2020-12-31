{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "sc-${version}";
  version = "0mrqq9";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "sc";
    rev    = "c4b1f01cdfc178cb98caff7b064af95f566c9914";
    sha256 = "0mrqq9a1zpmr876gr16fdjf1gvfzmr8gh33rkj6nc4rr0793ydph";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
