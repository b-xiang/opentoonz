#!/bin/bash
pushd toonz/sources
clang-format --version
git ls-files | egrep \\.\(c\|cpp\|h\|hpp\)$ | xargs clang-format -i && git diff --exit-code || exit 1
popd
pushd thirdparty/tiff-4.0.3
./configure && make
popd
cd toonz && mkdir build && cd build
cmake ../sources \
      -DQT_PATH=/usr/local/Cellar/qt@5.5/5.5.1/lib/ \
      -DTIFF_INCLUDE_DIR=../../thirdparty/tiff-4.0.3/libtiff/ \
      -DSUPERLU_INCLUDE_DIR=../../thirdparty/superlu/SuperLU_4.1/include/
make
