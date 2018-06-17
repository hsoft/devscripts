#!/bin/bash

# Returns the PyPI id of the specified atom. Returns error when there's no
# PyPI ID

equery meta -U $1 | grep -Po "[^\s]+(?= ID: pypi)"
