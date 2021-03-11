{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "e2e547";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "e2e547c8b6148b0300ce36e84b578339be40ac20";
    sha256 = "19w6ak4y6f6i6c9j0salx3n9fmz4s4pwqmh828svi69yahzlr8y9";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
