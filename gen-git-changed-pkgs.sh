#!/bin/bash

# Get a list of changed packages in commits from the Gentoo repo from HEAD to
# the specified commit

# Example
# gen-git-changed-pkgs.sh HEAD~100

git log --format="%s" $1..HEAD | grep -P -o "^[^\s/]+/[^\s:]+" | sort | uniq
