{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "17e24eb5832acc4d9900a60c91d297b73f46c7df";
    sha256 = "0m3kyqw89is61r906x5v0r8b0dg614k19kf2b2hr5bnrk7dss4yh";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
