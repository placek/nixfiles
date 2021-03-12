{ pkgs ? import <nixpkgs> {}, repos-dir ? "/var/git" }:

{
  repos-create = pkgs.stdenv.mkDerivation rec {
    name        = "repos-create";
    builder     = "${pkgs.sh}/bin/sh";
    args        = [ ./shell-script-builder.sh  ];
    buildInputs = [ pkgs.coreutils ];
    system      = builtins.currentSystem;
    src         = builtins.toFile "repos-create" ''
      #!/bin/sh

      reposDir="${repos-dir}"

      if [ -z "$1" ]; then
        echo "exiting, no repo name input to create"
        echo "usage: 'repos-create <repo>'"
        exit 1
      fi

      case "$1" in
      *.git)
        newRepoDir=$reposDir/$1 ;;
      *)
        newRepoDir=$reposDir/$1.git ;;
      esac

      if [ -d "$newRepoDir" ]; then
        echo "exiting, repo '$newRepoDir' already exists"
        exit 1
      else
        echo "creating new repo '$newRepoDir'"
        mkdir -p $newRepoDir
        git init --bare --template="$reposDir/template" "$newRepoDir"
        echo "new repo '$newRepoDir' created"
      fi
    '';
  };

  repos-delete = pkgs.stdenv.mkDerivation rec {
    name        = "repos-delete";
    builder     = "${pkgs.sh}/bin/sh";
    args        = [ ./shell-script-builder.sh  ];
    buildInputs = [ pkgs.coreutils ];
    system      = builtins.currentSystem;
    src         = builtins.toFile "repos-delete" ''
      #!/bin/sh

      reposDir="${repos-dir}"

      if [ -z "$1" ]; then
        echo "exiting, no repo name input to delete"
        echo "usage: 'repos-delete <repo>'"
        exit 1
      fi

      case "$1" in
      *.git)
        deleteRepoDir=$reposDir/$1
      *)
        deleteRepoDir=$reposDir/$1.git
      esac

      if [ ! -d "$deleteRepoDir" ]; then
        echo "exiting, repo '$deleteRepoDir' does not exist"
        exit 1
      fi

      read -p "are you sure to delete the repo '$deleteRepoDir' (y/n)? " choice
      case "$choice" in
      y|Y) echo "'yes' selected, deleting '$deleteRepoDir'" ;;
      n|N) echo "'no' selected, exiting" && exit 0 ;;
      *) echo "invalid option, exiting" && exit 1 ;;
      esac

      rm -rf $deleteRepoDir

      echo "repo '$deleteRepoDir' has been deleted"
    '';
  };

  repos-list = pkgs.stdenv.mkDerivation rec {
    name        = "repos-list";
    builder     = "${pkgs.sh}/bin/sh";
    args        = [ ./shell-script-builder.sh  ];
    buildInputs = [ pkgs.coreutils ];
    system      = builtins.currentSystem;
    src         = builtins.toFile "repos-list" ''
      #!/bin/sh

      reposDir="${repos-dir}"

      ls -d $reposDir/*.git | xargs -n1 basename
    '';
  };

  ci-list = pkgs.stdenv.mkDerivation rec {
    name        = "ci-list";
    builder     = "${pkgs.sh}/bin/sh";
    args        = [ ./shell-script-builder.sh  ];
    buildInputs = [ pkgs.coreutils ];
    system      = builtins.currentSystem;
    src         = builtins.toFile "ci-list" ''
      #!/bin/sh

      reposDir="${repos-dir}"

      ls $reposDir/pipelines/* | xargs -n1 basename
    '';
  };

  ci-show = pkgs.stdenv.mkDerivation rec {
    name        = "ci-show";
    builder     = "${pkgs.sh}/bin/sh";
    args        = [ ./shell-script-builder.sh  ];
    buildInputs = [ pkgs.coreutils ];
    system      = builtins.currentSystem;
    src         = builtins.toFile "ci-show" ''
      #!/bin/sh

      reposDir="${repos-dir}"

      if [ -z "$1" ]; then
        echo "exiting, no pipeline input to show"
        echo "usage: 'ci-show <pipeline>'"
        exit 1
      fi

      pipeline="$reposDir/pipelines/$1"

      if [ ! -f "$pipeline" ]; then
        echo "exiting, cannot find pipeline $pipeline"
        exit 1
      fi

      cat $pipeline
    '';
  };

  ci-run = pkgs.stdenv.mkDerivation rec {
    name        = "ci-run";
    builder     = "${pkgs.sh}/bin/sh";
    args        = [ ./shell-script-builder.sh  ];
    buildInputs = [ pkgs.coreutils ];
    system      = builtins.currentSystem;
    src         = builtins.toFile "ci-run" ''
      #!/bin/sh

      reposDir="${repos-dir}"
      pipelines="$reposDir/pipelines"

      if [ -z "$1" ]; then
        echo "exiting, no repo input to run"
        echo "usage: 'ci-run <repo>'"
        exit 1
      fi

      case "$1" in
      *.git)
        repoDir=$reposDir/$1 ;;
      *)
        repoDir=$reposDir/$1.git ;;
      esac

      if [ ! -d "$repoDir" ]; then
        echo "exiting, cannot find repo $repoDir"
        exit 1
      fi

      if [ ! -f "$workDir/.ci.runner" ] || [ ! -f "$workDir/.ci.image" ] || [ ! -f "$workDir/.ci.compose" ]; then
        echo "exiting, no CI configuration found in $repoDir"
        exit 1
      fi

      workDir=$(mktemp -d)
      git clone "$repoDir" "$workDir"

      ciRunner="$workDir/.ci.runner"
      ciImage="$workDir/.ci.image"
      ciCompose="$workDir/.ci.compose"

      exec $ciRunner
    '';
  };
}
