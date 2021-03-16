{ pkgs ? import <nixpkgs> {}, repos-dir ? "/var/git" }:

pkgs.stdenv.mkDerivation rec {
  name    = "git-shell-commands-${version}";
  version = "39d7e5";

  src = pkgs.fetchFromGitHub {
    owner  = "placek";
    repo   = "git-shell-commands";
    rev    = "39d7e518ce17c967e7590390b7579b235c65334c";
    sha256 = "1w4sv73fp5v8yampy2k1ncbkf2fv2mclqz67jbs9knprmdn6zqsm";
  };

  buildInputs  = [];
  buildPhase   = "";
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
