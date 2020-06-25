#!/bin/sh

mkdir -p /tmp/sway
XDG_RUNTIME_DIR=/tmp/sway ~/sway/build/sway/sway -d 2> ~/sway.log
