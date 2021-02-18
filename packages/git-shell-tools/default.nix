{ pkgs ? import <nixpkgs> {}, repos-dir ? "/var/git" }:

{
  repos-create = pkgs.stdenv.mkDerivation rec {
    name        = "repos-create";
    builder     = "${pkgs.sh}/bin/sh";
    args        = [ ./shell-script-builder.sh  ];
    buildInputs = [ pkgs.coreutils ];
    system      = builtins.currentSystem;
    src         = ''
      #!/bin/sh

      reposDir="${repos-dir}"
      set -e

      if [ -z "$reposDir" ] || [ ! -d "$reposDir" ]; then
        echo "exiting, can't find reposDir or env variables not set"
        exit 1
      fi

      if [ -z "$1" ]; then
        echo "exiting, no repo name input to create"
        echo "usage: 'repos-create <name-of-repo-to-create>'"
        exit 1
      fi

      case "$1" in
      *.git)
        newRepoDir=$reposDir/$1 ;;
      *)
        newRepoDir=$reposDir/$1.git ;;
      esac

      if [ -d "$newRepoDir" ]; then
        echo "repo: '$newRepoDir' already exists, exiting..."
        exit 1
      else
        echo "creating new repo: '$newRepoDir'"
        mkdir -p $newRepoDir
        git init --bare --template="$reposDir/template" "${newRepoDir}"
        echo "new repo: '$newRepoDir' created"
      fi
    '';
  };

  repos-delete = pkgs.stdenv.mkDerivation rec {
    name        = "repos-delete";
    builder     = "${pkgs.sh}/bin/sh";
    args        = [ ./shell-script-builder.sh  ];
    buildInputs = [ pkgs.coreutils ];
    system      = builtins.currentSystem;
    src         = ''
      #!/bin/sh

      reposDir="${repos-dir}"
      set -e

      if [ -z "$reposDir" ] || [ ! -d "$reposDir" ]; then
      	echo "exiting, can't find reposDir or env variables not set"
      	exit 1
      elif [ -z "$1" ]; then
        echo "exiting, no repo name input to delete"
        echo "usage: 'repos-delete <name-of-repo-to-delete>'"
        exit 1
      fi

      case "$1" in
      *.git)
        deleteRepoDir=$reposDir/$1
        deleteRepoBackupHash=$reposDir/sha-$1.sha256 ;;
      *)
        deleteRepoDir=$reposDir/$1.git
        deleteRepoBackupHash=$reposBackupDir/sha-$1.git.sha256 ;;
      esac

      if [ ! -d "$deleteRepoDir" ]; then
        echo "exiting, git repo at: '$deleteRepoDir' does not exist"
        exit 1
      fi

      read -p "would you like to delete the git repo at: '$deleteRepoDir' (y/n)? " choice
      case "$choice" in
      y|Y) echo "'yes' selected, deleting: '$deleteRepoDir'" ;;
      n|N) echo "'no' selected, exiting" && exit 0 ;;
      *) echo "invalid option, exiting" && exit 1 ;;
      esac

      rm -rf $deleteRepoDir

      if [ -f "$deleteRepoBackupHash" ]; then
        rm $deleteRepoBackupHash
      fi

      echo "git repo '$deleteRepoDir' has been deleted"
    '';
  };

  repos-list = pkgs.stdenv.mkDerivation rec {
    name        = "repos-list";
    builder     = "${pkgs.sh}/bin/sh";
    args        = [ ./shell-string-script-builder.sh  ];
    buildInputs = [ pkgs.coreutils ];
    system      = builtins.currentSystem;
    src         = ''
      #!/bin/sh

      reposDir="${repos-dir}"
      ls -d $reposDir/*.git | xargs -n1 basename
    '';
  };
}
