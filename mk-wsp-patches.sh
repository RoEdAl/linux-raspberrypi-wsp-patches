#!/bin/bash

function make_wsp_patches() {
    patchdir=$(pwd)
    workdir=$(mktemp -p $HOME -d)
    git clone http://github.com/HiassofT/rpi-linux.git -b $1 $workdir || exit 1
    cd $workdir
    git format-patch -o $patchdir -k $2
 
    cd $patchdir
    rm -rf $workdir
}

make_wsp_patches cirrus-4.4.y e98827a9830b1cbca4e0f04f5db9352c15c06f6f
