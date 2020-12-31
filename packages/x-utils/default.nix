{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "x-utils-${version}";
  version = "0wzm9r";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "x-utils";
    rev    = "5f28a955ad0b3a87172adc2012445379b00fe2e4";
    sha256 = "0wzm9rv7as3flrd75d1z5c561lq3zzwxp0avximgydh78jrzmxbi";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
