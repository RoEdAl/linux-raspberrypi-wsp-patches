#!/bin/bash

function make_squashed_patch() {
    patchdir=$(pwd)
    workdir=$(mktemp -p $HOME -d)
    git clone http://github.com/raspberrypi/linux.git -b $1 $workdir || exit 1
    cd $workdir
    git checkout -b wsp-patches
    for i in $(cd $patchdir && ls *.patch); do
	git am -k < $patchdir/$i
    done
    git checkout $1
    git checkout -b tmpsquash
    git merge --squash wsp-patches
    git commit -a --author="RoEdAl <roed@onet.eu>" --date="2000-01-01 00:00:00 +0000" -m 'Add support to Cirrus Logic/Wolfson sound card' -m '' -m 'Squashed commits'
    git format-patch --minimal -k -o $patchdir/squashed $1
 
    cd $patchdir
    rm -rf $workdir
}

make_squashed_patch rpi-4.4.y
