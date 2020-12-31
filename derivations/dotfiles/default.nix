{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "723556";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "723556ae5b110701a1e0d83f4ee748fdb6600177";
    sha256 = "1w2vnki6hldx2yq2bgvrn30b9f58f9a3w8vg6g5bhg8aasy9z7xw";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
