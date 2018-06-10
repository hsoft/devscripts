#!/bin/bash

# Performs a git pull on the current gentoo repo and verify signatures of the
# newly pulled commits. After than, regenerate the metadata cache only for
# packages that were changed by the pulled commits.
# Takes no argument.

BEGIN_COMMIT=$(git rev-list -n1 master)

git pull

verif-sign-until.sh $BEGIN_COMMIT

for pkg in $(gen-git-changed-pkgs.sh $BEGIN_COMMIT); do
    echo "Regenerating cache for $pkg"
    egencache --repo gentoo --update $pkg
done
