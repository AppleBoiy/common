#!/usr/bin/env bash

read -p "Commit message: " commit_message

if [ -z "$commit_message" ]; then
  echo "No commit message provided: (chore): update submodules by default"
  commit_message="(chore): update submodules"
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
git push