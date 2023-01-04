#!/bin/sh
# Set up emscripten

if [[ -z "${EMSDK}" ]]; then
  echo "Installing emscripten..."
  echo ""
  git submodule init
  git submodule update
  cd emsdk
  ./emsdk install latest && ./emsdk activate latest
  source ./emsdk_env.sh
  cd ..
fi

mkdir -p jsbuild && cd jsbuild && rm -rf *
emconfigure cmake .. -DNO_AES=1 -DARCH=default -DBUILD_WASM=1 -DBUILD_JS=0
make
emconfigure cmake .. -DNO_AES=1 -DARCH=default -DBUILD_WASM=0 -DBUILD_JS=1
make
