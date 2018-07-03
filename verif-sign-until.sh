#!/bin/bash

# Easily verify signature of commits in a git repo, from HEAD until the
# specified commit. Will stop on verification failure.

# Example:
# verif-sign-until.sh HEAD~100

# TODO: use trust levels to error out on untrusted keys

for commit in $(git rev-list $1..HEAD); do
    msg=$(git --no-pager log -1 --oneline $commit)
    echo "Verifying $msg"
    if ! git verify-commit $commit > /dev/null 2>&1 ; then
        echo "Verification failed!"
        git --no-pager log -1 --pretty=fuller $commit
        git verify-commit $commit
        exit 1
    fi
done
exit 0
