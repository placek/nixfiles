#!/bin/sh

set -e

. repos-setenvvars

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
    cd $newRepoDir
    git init --bare
    echo "new repo: '$newRepoDir' created"
fi
