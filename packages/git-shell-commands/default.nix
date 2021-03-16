{ pkgs ? import <nixpkgs> {}, repos-dir ? "/var/git" }:

pkgs.stdenv.mkDerivation rec {
  name    = "git-shell-commands-${version}";
  version = "d36fac";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "git-shell-commands";
    rev    = "d36facbd888813f6a722f081b293e80477efc840";
    sha256 = "1c9b7f31rgwd5cg56m843akinczmkyhdlqmqr1gw87ng06gakmq7";
  };

  buildInputs  = [];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
