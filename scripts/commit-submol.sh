#!/usr/bin/env bash

read -r commit_message

if [ -z "$commit_message" ]; then
    cat <<EOF
Usage:
run: ./scripts/
  git_commit_submodule.sh "commit message"
makefile:
  commit-submodul "commit message"
This script commits all submodules and the parent repository with the same commit message.
EOF

    exit 1
fi

for submodule in $(git submodule | awk '{ print $2 }'); do
    echo "Committing $submodule"
    cd "$submodule" || { echo "Failed to cd into $submodule"; exit 1; }
    git add .
    git commit -m "$commit_message"
    cd ..
done

echo "Committing parent repository"
git add .
git commit -m "$commit_message"
