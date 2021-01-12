{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "a7f3fd";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "a7f3fdb80fedcae5551c7f16c6e96081b065f8d6";
    sha256 = "0ah9caq3878jr1ml4amc67mbvg67aycbn61rvivg7apwnc48ns7a";
  };

  buildInputs = [ pkgs.haskellPackages.mustache ];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
