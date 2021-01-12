{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "f9f282";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "f9f28289b2917ce525c929d90007f1e5d78f890c";
    sha256 = "0gigrsr11f628v9cvz3n78cmy3rs6c70ihd1lar9p7rbcl86k37y";
  };

  buildInputs = [ pkgs.haskellPackages.mustache ];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
