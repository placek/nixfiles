{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "653e7d370fa47a7bf7e1f809b15132b64e8cb790";
    sha256 = "0jmc33pccwnh5qhj6ik0nac5xnzb3hcyh7gpw2ci7rp4wi3dcyi6";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
