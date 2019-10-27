#!/usr/bin/env bash

export PS4="\n$ "
set -xe

# install depot_tools
git clone "https://chromium.googlesource.com/chromium/tools/depot_tools.git" depot_tools || true
(
  cd depot_tools
  git fetch
  git pull origin master
)
export PATH="$PWD/depot_tools:$PATH"


# get pdfium code
mkdir -p repo
cd repo
gclient config --unmanaged "https://pdfium.googlesource.com/pdfium.git"
gclient sync
cd pdfium

# configure build
mkdir -p out/build
gn gen out/build

# run ninja build
ninja -C out/build pdfium_all