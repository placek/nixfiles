{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "aa43b670f7570d9eb52b2022f9ae3a1ce4df0ecb";
    sha256 = "1nxmgw76nrjhcqfk1agg6m8qjgkh7k50mv8i0jfb0wr6q9ayyyxp";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
