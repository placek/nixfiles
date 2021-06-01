{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "projects-${version}";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "projects";
    rev    = "4e28e3156ab9ac00245c601cb6f89c4b298eaf68";
    sha256 = "08v84hfjp1w7mw2db07lsmh088qgqb0748xr442mfq1204v53glg";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
