{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dotfiles-${version}";
  version = "deb2f5";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "dotfiles";
    rev    = "deb2f5f63e7f5d56e1e7d7e6c86a1c35bd5a360b";
    sha256 = "02srb5638k20gbl6zgqhvj4ynj651n4x78ldaxwzrcim16r040p7";
  };

  buildInputs = [ pkgs.haskellPackages.mustache ];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
