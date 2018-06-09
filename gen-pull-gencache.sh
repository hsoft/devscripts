#!/bin/bash

# Performs a git pull on the current gentoo repo and verify signatures of the
# newly pulled commits. After than, regenerate the metadata cache only for
# packages that were changed by the pulled commits.
# Takes no argument.

BEGIN_COMMIT=$(git rev-list -n1 master)

git pull

verif-sign-until.sh $BEGIN_COMMIT

PKGS=$(gen-git-changed-pkgs.sh $BEGIN_COMMIT | xargs)

echo "Regenerating cache for $PKGS"

egencache --jobs=4 --repo gentoo --update $PKGS
