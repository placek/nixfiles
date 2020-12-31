{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "projects-${version}";
  version = "0f8b27";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "projects";
    rev    = "0f8b27c61f602b87b08bd3b5865e79bef130c3f2";
    sha256 = "0dkz9l2ikpv62r1yjnq318cd5s0jci9hsv7f0r5madw1zn33dj8l";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
