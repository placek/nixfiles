{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "57f6e5";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "57f6e598c5454402ac628e8d189791673418a2ba";
    sha256 = "0zgssjhpdv7p7hwg99lsdb58m9v2vw8qh75s2hpkc2qs4jzk38ks";
  };

  buildInputs = [ pkgs.haskellPackages.mustache ];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
