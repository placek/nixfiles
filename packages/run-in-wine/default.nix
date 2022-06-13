{ pkgs, name, cpath, exe, prefix, args ? "" }:

pkgs.stdenv.mkDerivation {
  name = "wine-${name}";
  src = builtins.toFile "wine-${name}.sh" ''
    #!/usr/bin/env bash
    rm -f "$HOME/.wine"
    ln -s "${prefix}" "$HOME/.wine"
    cd "$HOME/.wine/drive_c/${cpath}"
    exec wine "${exe}" ${args}
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
