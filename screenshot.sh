#!/bin/sh

DESTDIR=~/screenshots
mkdir -p $DESTDIR

FNAME=$DESTDIR/$(date +%Y_%m_%d_%H_%M.png)
grim -g "$(slurp)" $FNAME
wl-copy < $FNAME
