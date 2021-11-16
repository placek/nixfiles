{ pkgs ? import <nixpkgs> {} }:

let
  pin  = pkgs.lib.importJSON ./source.json;
in
  pkgs.stdenv.mkDerivation rec {
    pname   = "dotfiles";
    version = builtins.substring 0 6 src.rev;

    src = pkgs.fetchFromGitHub {
      owner = "placek";
      repo  = "dotfiles";
      inherit (pin) rev sha256;
    };

    buildInputs  = [ pkgs.haskellPackages.mustache ];
    buildPhase   = "";
    installPhase = ''
      mkdir -p $out
      cp -r * $out
    '';
  }
