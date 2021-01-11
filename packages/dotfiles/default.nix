{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "16778e";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "16778e9421d2b6b3bb3b4434e585c13fc33330d3";
    sha256 = "057q8rza9li113r7l8qfi63l9vpacq4l8wj2204v4l7q2rhacxiy";
  };

  buildInputs = [ pkgs.haskellPackages.mustache ];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
