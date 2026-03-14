#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OSSFUZZ="$ROOT/oss-fuzz"

cd "$OSSFUZZ"

echo "Running regression tests on valid PNG inputs..."

python infra/helper.py reproduce libpng course_png_fuzzer "$ROOT/seed_corpus/pngnow.png"
python infra/helper.py reproduce libpng course_png_fuzzer "$ROOT/seed_corpus/pngtest.png"

echo
echo "Regression test completed."
echo "If your fixes are correct, these inputs should run without sanitizer errors."