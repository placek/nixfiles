{ pkgs, name, cpath, exe, prefix }:

pkgs.stdenv.mkDerivation {
  name = "wine-${name}";
  src = builtins.toFile "wine-${name}.sh" ''
    #!/usr/bin/env bash
    cd "${prefix}/drive_c/${cpath}"
    exec wine "${exe}"
  '';
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/wine-${name}
    chmod +x $out/bin/wine-${name}
  '';
  buildInputs = [];
  propagatedBuildInputs = [ pkgs.wineWowPackages.stable ];
}
