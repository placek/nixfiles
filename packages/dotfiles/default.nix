{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "f2e621";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "f2e62138bd2707c8bc3cc9ca92cf7fd3037ffb3e";
    sha256 = "00sf47x77rzrh603dmlvfv6yyqlgb3bd0h2xnflkximfjhxh567y";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
