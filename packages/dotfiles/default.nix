{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "9a23ff";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "9a23ff833ebe28ac9aea0b7b5985b5c0a15559ed";
    sha256 = "1wpr69gdrbyz55ydh9i3q4qdg0hzr5la85sj7b6clnhfwz7a4bjq";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
