{ pkgs ? import <nixpkgs> {} }:

let
  cbqn-bytecode-files = pkgs.fetchFromGitHub {
    name  = "cbqn-bytecode-files";
    owner = "dzaima";
    repo  = "CBQN";
    rev   = "db686e89d4d2e9bfac3dddf306dff890135b2de1";
    hash  = "sha256-RJ751jCsAGjqQx3V5S5Uc611n+/TBs6G2o0q26x98NM=";
  };
in
  pkgs.stdenv.mkDerivation rec {
    pname   = "cbqn";
    version = "0.pre+date=2021-11-06";

    src = pkgs.fetchFromGitHub {
      owner = "dzaima";
      repo  = "CBQN";
      rev   = "cd866e1e45ce0f22bfacd25565ab912c06cb040f";
      hash  = "sha256-XuowrGDgrttRL/SY5si0nqHMKEidSNrQuquxNdBCW8o=";
    };

    dontConfigure = true;

    postPatch = ''
      sed -i '/SHELL =.*/ d' makefile
    '';

    makeFlags = [
      "CC=${pkgs.stdenv.cc.targetPrefix}cc"
    ];

    preBuild = ''
      touch src/gen/customRuntime
      cp ${cbqn-bytecode-files}/src/gen/{compiler,formatter,runtime0,runtime1,src} src/gen/
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin/
      cp BQN $out/bin/cbqn
      ln -s $out/bin/cbqn $out/bin/bqn
      runHook postInstall
    '';
  }
