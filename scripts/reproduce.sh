#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <path-to-input>"
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INPUT="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"

cd "$ROOT/oss-fuzz"
python infra/helper.py reproduce libpng course_png_fuzzer "$INPUT"