#!/bin/bash -eu

echo "[course] Building libpng (cmake) using system zlib..."
cd "$SRC/libpng"

rm -rf build
mkdir -p build
cd build

cmake -G Ninja \
  -DPNG_SHARED=OFF \
  -DPNG_TESTS=OFF \
  -DPNG_EXECUTABLES=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER="$CC" \
  -DCMAKE_CXX_COMPILER="$CXX" \
  -DCMAKE_C_FLAGS="$CFLAGS" \
  -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
  -DCMAKE_INSTALL_PREFIX=/usr/local \
  ..

ninja
ninja install

echo "[course] Building course fuzzer..."
COURSE_DIR="$SRC/libpng/course"

$CXX $CXXFLAGS -I"$SRC/libpng" -I"$COURSE_DIR" \
  "$COURSE_DIR/course_png_fuzzer.cc" \
  "$COURSE_DIR/course_vuln.c" \
  -o "$OUT/course_png_fuzzer" \
  $LIB_FUZZING_ENGINE \
  -lpng -lz

echo "[course] Done. Output:"
ls -l "$OUT" | sed -n '1,120p'
