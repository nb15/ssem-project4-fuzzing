#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="libpng-course"

cd "$ROOT/oss-fuzz"

# Clean old outputs
rm -rf "$ROOT/oss-fuzz/build/out/$PROJECT"

# Remove conflicting images (important!)
docker image rm gcr.io/oss-fuzz/libpng >/dev/null 2>&1 || true
docker image rm gcr.io/oss-fuzz/$PROJECT >/dev/null 2>&1 || true

# Clear build cache
docker builder prune -f >/dev/null 2>&1 || true

python3 infra/helper.py build_image "$PROJECT"
python3 infra/helper.py build_fuzzers --clean "$PROJECT"

if [ ! -f "$ROOT/oss-fuzz/build/out/$PROJECT/course_png_fuzzer" ]; then
  echo "ERROR: course_png_fuzzer not built."
  ls -l "$ROOT/oss-fuzz/build/out/$PROJECT" || true
  exit 1
fi

cd "$ROOT/seed_corpus"
zip -q -r seed.zip ./*.png
cp seed.zip "$ROOT/oss-fuzz/build/out/$PROJECT/course_png_fuzzer_seed_corpus.zip"

echo "Build completed successfully."