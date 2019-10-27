#!/usr/bin/env bash

export PS4="\n$ "
set -xe

# install depot_tools
(
  git clone "https://chromium.googlesource.com/chromium/tools/depot_tools.git" depot_tools || true
  cd depot_tools
  git fetch
  git pull origin master
)

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
