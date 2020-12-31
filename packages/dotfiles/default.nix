{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "28d6b0";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "28d6b0e740ebe421165ece49291c762196c7beda";
    sha256 = "1s1b84jc0dd6qfcks7qwf2165idh2x3wd7rzhs21pg8cv6yxmphh";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
