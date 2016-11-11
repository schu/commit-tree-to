#!/bin/sh

die () {
  echo $@
  exit 1
}

if [ $# -ne 2 ]
then
  die "Usage: $0 <dir> <branch>"
fi

if ! git rev-parse --git-dir >/dev/null 2>&1
then
  die "Not a Git repository"
fi

src=$1
dst=$2
dir=$(mktemp -d XXXXXXXX)
trap "rm -rf $dir" EXIT

tree=$( (
export GIT_INDEX_FILE="$dir/index" &&
git ls-files -z -o "$src" |
git update-index -z --add --remove --stdin &&
git write-tree --prefix="$src"
) ) || die "Failed to generate temporary tree"

commit=$(echo "Automatically generated with commit-tree-to - https://github.com/schu/commit-tree-to" | git commit-tree $tree)
git update-ref "refs/heads/$dst" $commit
