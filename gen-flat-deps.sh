#!/bin/bash

# Returns dependencies for given package, flatly, in no particular order.
# Useful to pipe into something else.
# By default, return deep deps. If specified, the second argument will be
# depth

PKG=$1
DEPTH=${2:-0}
equery -qC g -lUMA --depth=${DEPTH} "${PKG}" \
    | grep -Po "[\w-]+/[\w-]+" \
    | xargs -L1 -- qatom -F "%{CATEGORY}/%{PN}" \
    | tail -n +2
