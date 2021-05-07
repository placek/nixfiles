{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "18218d";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "18218d6951628dbdd12c1e614e4646e3606b0aec";
    sha256 = "1iixydnkaxzwa8g7369n44krapgphsr6d5d4ni4wmaimy9dagbqp";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
