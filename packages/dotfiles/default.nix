{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "8c3736";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "8c37366829eab5f4eb24cd2f59d3441512c4bda8";
    sha256 = "1gpi2kq7yv0k08gw2i004n0vffyfywgldqnybynh0m44q35i68dg";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
