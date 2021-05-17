{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "dca0fd";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "dca0fd562c711147c67543fbdc146f87d1a8db99";
    sha256 = "07api2r4s2aj9hpgfv9d1hg7w93za3pxibdw3d45qpa4q5q9mp16";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
