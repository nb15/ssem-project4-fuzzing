#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="libpng-course"

cd "$ROOT/oss-fuzz"

echo "Running regression tests..."

python3 infra/helper.py reproduce "$PROJECT" course_png_fuzzer "$ROOT/seed_corpus/pngnow.png"
python3 infra/helper.py reproduce "$PROJECT" course_png_fuzzer "$ROOT/seed_corpus/pngtest.png"

echo "Done."