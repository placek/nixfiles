{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "425b08";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "425b08df55bd5a4b470bdd4a21b1597a8aac05f5";
    sha256 = "066b1vxjry2yhklhqy403blhs9pfpxzaf068l70ah51g1q0m54z9";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
