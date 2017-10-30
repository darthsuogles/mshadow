#!/bin/bash

_bsd_="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pushd "${_bsd_}"

brew install openblas

(mkdir -p build-tree && cd $_
 cmake -D CMAKE_INSTALL_PREFIX=$PWD/../install_dir ..
 make -j8
)

popd
