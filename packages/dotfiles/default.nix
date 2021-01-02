{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "f7540a";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "f7540ac41d0a53f2f506aea176fcc0e81f236b2d";
    sha256 = "0wpfcjvphrf5qp6g3xfkc12gr9sml26qdg4mcsf0y2f74jnsh7rv";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
