{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "projects-${version}";
  version = "1.2";

  src = ../../sources/projects;

  buildPhase = "";
  installPhase = ''
    mkdir -p $out/bin
    cp $src/* $out/bin
    chmod +x $out/bin/*
  '';
}
