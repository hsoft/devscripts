#!/bin/bash

# Find maintainer-less packages among the packages installed on the system.

for pkg in $(qlist -I) ; do
    maintainers=$(equery -q meta -m "${pkg}")
    if [[ -z "$maintainers" ]]; then
        echo "$pkg"
    fi
done
