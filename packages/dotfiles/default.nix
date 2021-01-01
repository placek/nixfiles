{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "0drm7x";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "4f292633960ac9b93e6eb5c26920903d60000dc4";
    sha256 = "0drm7xy85qk3w3h9kxsqvhg9jxjinznpy8y4zqfrdxvbb3j1n6rs";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
