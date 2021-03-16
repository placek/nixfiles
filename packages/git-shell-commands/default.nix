{ pkgs ? import <nixpkgs> {}, repos-dir ? "/var/git" }:

pkgs.stdenv.mkDerivation rec {
  name    = "git-shell-commands-${version}";
  version = "f750ef";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "git-shell-commands";
    rev    = "f750ef71d7a116f715fe91403b037a5d1ae58b92";
    sha256 = "1ch5vnfbsi9z1715bplvqgl7w1gkwqv1jcadk6rr5qbfy8c7i9k8";
  };

  buildInputs  = [];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
