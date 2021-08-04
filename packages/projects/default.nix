{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "projects-${version}";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "projects";
    rev    = "1404b378cbcff6b6e5c47e104dd57c4f9b564389";
    sha256 = "0wa9jrsbj3fl0jqaqykqmph0k5jm0g3xax3m4fhgwpscvmh4qkgz";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
