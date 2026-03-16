#!/usr/bin/env bash
set -euo pipefail

TIME="${1:-180}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="libpng-course"

cd "$ROOT/oss-fuzz"
python3 infra/helper.py run_fuzzer "$PROJECT" course_png_fuzzer -- -max_total_time="$TIME"