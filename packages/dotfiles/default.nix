{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "28e4f6";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "28e4f64c88c27e99fea2e215b2a28cb875e7ed1a";
    sha256 = "1i5g139ramngbi9fqbcqr6bh7lcy5372wfxbsih051klz9n02nhd";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
