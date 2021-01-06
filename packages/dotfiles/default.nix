{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "9681b6";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "9681b6f969b7771ef2fda4730b69d4a9d8f45fde";
    sha256 = "1mgmqp9iamsfr96l1qifpwhcgbvcqw8jqa215w0rmhs71afrabm5";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
