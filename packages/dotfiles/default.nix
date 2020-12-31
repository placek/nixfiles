{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "b63aa9ce51d8a46fa0405a70ca5bd75039fad26a";
    sha256 = "1956vqjv3qm1qbrajds7h835j86znxnhq0pjdglpgidclrvi4xwd";
  };

  buildInputs = [ pkgs.stow ];
  buildPhase = "";
  installPhase = ''
    sed -i 's#^stow=.*$#stow="${pkgs.stow}/bin/stow"#' bin/dots
    mkdir -p $out
    cp -r * $out
  '';
}
