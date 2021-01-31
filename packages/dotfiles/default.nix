{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "994117";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "9941178ae37bd3fff9d845d97774bd4d7d14c9ef";
    sha256 = "16b8nkf3sg37r74mwx8719pgqc3xw3rgvc093pkphdnfy1n6bcdi";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
