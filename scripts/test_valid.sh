#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OSSFUZZ="$ROOT/oss-fuzz"

cd "$OSSFUZZ"

python infra/helper.py reproduce libpng course_png_fuzzer "$ROOT/seed_corpus/pngnow.png"
python infra/helper.py reproduce libpng course_png_fuzzer "$ROOT/seed_corpus/pngtest.png"

echo "Valid-input regression test completed."