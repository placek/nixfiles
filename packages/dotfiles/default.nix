{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname   = "dotfiles";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "eb5ca0eb6ce75d3456a46149a70102c7e94bd04b";
    sha256 = "0xwic6086yp6s7f9a1qi6y5sqhbw2pds0l200hzzq7xsv5kj93wm";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
