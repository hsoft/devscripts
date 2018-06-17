#!/bin/bash

# Checks the package specified at $1 on PyPI and compares the latest version to
# the ebuild version. 
#
# Example:
# qlist -I | xargs -L1 -- ./gen-pypi-version.sh
#
# = app-misc/asciinema-2.0.1 asciinema 2.0.1
# = dev-python/alabaster-0.7.10 alabaster 0.7.10
# ! dev-python/asn1crypto-0.24.0 cryptography 2.2.2
# ! dev-python/Babel-2.5.3-r1 Babel 2.6.0
# [...]
#
# (the asn1crypto thing seems to be caused by bad metadata.xml)

PYPI_NAME=$(gen-pypi-id.sh $1) || exit 1
FULL_ATOM=$(ACCEPT_KEYWORDS="~amd64" portageq best_visible / ebuild $1) || exit 2
EBUILD_VERSION=$(qatom -F "%{PV}" $FULL_ATOM)
JSON=$(curl "https://pypi.org/pypi/${PYPI_NAME}/json" 2> /dev/null) || exit 3
PYPI_VERSION=$(jq -r ".info.version" <<< $JSON) || exit 4

if [[ $EBUILD_VERSION == $PYPI_VERSION ]]; then
    echo -n "= "
else
    echo -n "! "
fi

echo $FULL_ATOM $PYPI_NAME $PYPI_VERSION

