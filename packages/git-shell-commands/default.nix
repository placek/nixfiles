{ pkgs ? import <nixpkgs> {}, repos-dir ? "/var/git" }:

pkgs.stdenv.mkDerivation rec {
  name    = "git-shell-commands-${version}";
  version = "c948b8";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "git-shell-commands";
    rev    = "c948b898168f05391456835d7bdffc3a0f28e21f";
    sha256 = "1r41f8phs2w9abqas6hvg43m56hc6d8i0q6lqbia4r853ziw2pgm";
  };

  buildInputs  = [];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
