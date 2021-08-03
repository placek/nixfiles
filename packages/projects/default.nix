{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "projects-${version}";
  version = builtins.substring 0 6 src.rev;

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "projects";
    rev    = "54513be610572ba42555c950d45aa9b5e70816fd";
    sha256 = "1nmcipl59r9c7m1cz4zzs43cswvji9pd84rh0rccp8y1yvwnfn8q";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
