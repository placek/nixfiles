{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "a5a5736ad1a63feb707e2eb0c3785a511e6c9115";
    sha256 = "1fsbr3fwq30kpv41af4gd55r9bghpgly4qfl1x1vp1b8qgcwjlq1";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
