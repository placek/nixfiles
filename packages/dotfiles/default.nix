{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "65867b";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "65867b07c2299b5dd4cb3c1c920fd7e02a4d5c46";
    sha256 = "0x3l14pn041z0q6cbhpzgvxx3dwbcb6rkch7z3ag6plv2rvbmv4g";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
