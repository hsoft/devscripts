#!/bin/bash

# Starts a LXC container and run a bash prompt inside it. When the prompt exits, stop the container.

set -e

lxc-start $1
lxc-attach --clear-env -v HOME=/root $1
lxc-stop $1
