#!/bin/bash

# Performs a git pull on the current gentoo repo and verify signatures of the
# newly pulled commits. After than, regenerate the metadata cache
# Takes no argument.

BEGIN_COMMIT=$(git rev-list -n1 master)

git pull

verif-sign-until.sh $BEGIN_COMMIT

for x in dtd glsa news xml-schema; do
    git -C metadata/${x} pull
done

echo "Regenerating cache..."
egencache --jobs=4 --repo gentoo --update
