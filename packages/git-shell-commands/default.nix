{ pkgs ? import <nixpkgs> {}, repos-dir ? "/var/git" }:

pkgs.stdenv.mkDerivation rec {
  name    = "git-shell-commands-${version}";
  version = "69adb2";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "git-shell-commands";
    rev    = "69adb2564fefb76e369b9e1649c235f5c19a4326";
    sha256 = "0r1d8nf3vx5kvy358lbznly8r37wcgf1wa73alcrdl485lsgr4rr";
  };

  buildInputs  = [];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
