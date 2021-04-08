{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "e2e547";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "aa65aeff3dc6ce7d2a43975211ab4fade6604a8b";
    sha256 = "1mhncwkwjnac75hnjb55qcx8m44b03viydb2qk31m9nvi9g14033";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
