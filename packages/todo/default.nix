{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "todo-${version}";
  version = "07p5v8";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "todo";
    rev    = "9daf4dba6bfb14a17be3b5a230d4bda4abb56a92";
    sha256 = "07p5v89migzw70jg71fh275y5ydnl5x75ba5n35g332fncr39y18";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
