{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "beaeac";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "beaeac438c72d92ce1ed95b93fc42ecb9dc1c2b9";
    sha256 = "0dgyxl52wgf2d4rmw06xay5n64z4kfcaa6rz92shws9hy1apkqd4";
  };

  buildInputs = [ pkgs.haskellPackages.mustache ];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
