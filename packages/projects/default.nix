{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "projects-${version}";
  version = "1dzxfx";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "projects";
    rev    = "c036d7808aff176f5052fbc727ccf52d3ebea5f9";
    sha256 = "1dzxfxspbb45dwp0sji0dlzjaj92k7frjyg68gyr14qvg7vq6dl4";
  };

  buildInputs = [];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
