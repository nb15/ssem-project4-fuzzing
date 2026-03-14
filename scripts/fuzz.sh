#!/usr/bin/env bash
set -euo pipefail

TIME="${1:-180}"

cd "$(dirname "$0")/../oss-fuzz"
python infra/helper.py run_fuzzer libpng course_png_fuzzer -- -max_total_time="$TIME"