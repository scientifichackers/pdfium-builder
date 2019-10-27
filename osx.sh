#!/usr/bin/env bash

export PS4="\n$ "
set -xe

# install depot_tools
if [ -d "depot_tools" ]; then
    cd depot_tools 
    git fetch
    git pull origin master
    cd ..
else
    git clone "https://chromium.googlesource.com/chromium/tools/depot_tools.git" depot_tools
fi
export PATH="$PWD/depot_tools:$PATH"

ls -la depot_tools
env
ls -la depot_tools/gclient

# get pdfium code
mkdir -p repo
cd repo
gclient config --unmanaged "https://pdfium.googlesource.com/pdfium.git"
gclient sync
cd pdfium
./build/install-build-deps.sh
