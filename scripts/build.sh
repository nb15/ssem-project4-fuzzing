#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cd "$ROOT/oss-fuzz"

# Clean previous build output for this project.
rm -rf "$ROOT/oss-fuzz/build/out/libpng"

# Remove the cached project image if it exists, so we rebuild from the current repo state.
docker image rm gcr.io/oss-fuzz/libpng >/dev/null 2>&1 || true

python3 infra/helper.py build_image libpng
python3 infra/helper.py build_fuzzers --clean libpng

if [ ! -f "$ROOT/oss-fuzz/build/out/libpng/course_png_fuzzer" ]; then
  echo "ERROR: expected oss-fuzz/build/out/libpng/course_png_fuzzer, but it was not built."
  echo "Contents of oss-fuzz/build/out/libpng:"
  ls -l "$ROOT/oss-fuzz/build/out/libpng" || true
  exit 1
fi

cd "$ROOT/seed_corpus"
zip -q -r seed.zip ./*.png
cp seed.zip "$ROOT/oss-fuzz/build/out/libpng/course_png_fuzzer_seed_corpus.zip"

echo "Seed corpus installed at oss-fuzz/build/out/libpng/course_png_fuzzer_seed_corpus.zip"
echo "Build completed successfully."