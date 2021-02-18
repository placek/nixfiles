{ pkgs ? import <nixpkgs> {}, repos-dir ? "/var/git" }:
let
  stdenv = pkgs.stdenv;
  sh = pkgs.sh;
  coreutils = pkgs.coreutils;
in
  {
    repos-create = stdenv.mkDerivation rec {
      name = "repos-create";
      builder = "${sh}/bin/sh";
      args = [ ./shell-script-builder.sh  ];
      src = ./repos-create.sh;
      buildInputs = [ coreutils ];
      system = builtins.currentSystem;
    };

    repos-delete = stdenv.mkDerivation rec {
      name = "repos-delete";
      builder = "${sh}/bin/sh";
      args = [ ./shell-script-builder.sh  ];
      src = ./repos-delete.sh;
      buildInputs = [ coreutils ];
      system = builtins.currentSystem;
    };

    repos-list = stdenv.mkDerivation rec {
      name = "repos-list";
      builder = "${sh}/bin/sh";
      args = [ ./shell-string-script-builder.sh  ];
      src = ''
        #!/bin/sh
        . repos-setenvvars
        ls -d $reposDir/*.git | xargs -n1 basename
      '';
      buildInputs = [ coreutils ];
      system = builtins.currentSystem;
    };

    repos-setenvvars = stdenv.mkDerivation rec {
      name = "repos-setenvvars";
      builder = "${sh}/bin/sh";
      args = [ ./shell-string-script-builder.sh  ];
      src = ''
        #!/bin/sh
        reposDir="${repos-dir}" #directory containing the git repos
      '';
      buildInputs = [ coreutils ];
      system = builtins.currentSystem;
    };
  }
