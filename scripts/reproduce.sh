#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <input>"
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="libpng-course"
INPUT="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"

cd "$ROOT/oss-fuzz"
python3 infra/helper.py reproduce "$PROJECT" course_png_fuzzer "$INPUT"