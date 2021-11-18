{ stdenv, ... }:

stdenv.mkDerivation rec {
  pname = "custom-fonts";
  version = "v1.0";
  src = ./sources;
  buildPhase = "";
  installPhase = ''
    runHook preInstall
    fontdir="$out/share/fonts/truetype"
    mkdir -p $fontdir
    cp $src/* $fontdir
    runHook postInstall
  '';
  dontConfigure = true;
}
