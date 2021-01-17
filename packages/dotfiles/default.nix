{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name    = "dotfiles-${version}";
  version = "dcde253";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "dcde253f69cb145f5560b4acdfb8bb8df075c065";
    sha256 = "03bsdhhw1y30xmi2kd17lcfb3fhqiycgiby91qbwvszcyjdwd7hc";
  };

  buildInputs  = [ pkgs.haskellPackages.mustache ];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
