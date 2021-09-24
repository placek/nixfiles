{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "08cc75465352bd5fe2369ebf50271b8963d2a5a0";
    sha256 = "0k49xl2kancwj7fzsc7992lkp6z53c19kxsgvk6m0g36zac8yhip";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
