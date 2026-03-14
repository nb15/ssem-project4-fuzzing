#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cd "$ROOT/oss-fuzz"
python infra/helper.py build_image libpng
python infra/helper.py build_fuzzers --clean libpng

cd "$ROOT/seed_corpus"
zip -q -r seed.zip ./*.png
cp seed.zip "$ROOT/oss-fuzz/build/out/libpng/course_png_fuzzer_seed_corpus.zip"

echo "Seed corpus installed at oss-fuzz/build/out/libpng/course_png_fuzzer_seed_corpus.zip"