{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "868049";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "868049bf643d1f63cdcc9eff381b71e7d130289b";
    sha256 = "0kkygg4qrn2dh54yjnnfqqh5rxrjn043zg26ypmbg3r0srgk3i4a";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
