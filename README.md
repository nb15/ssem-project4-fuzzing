# SSEM Project 4: Find and Fix Bugs with Fuzzing

This repository contains the materials for Project 4 in Secure System Engineering and Management.

## Repository Layout

- `libpng-course/` — buggy course-owned target code based on `libpng`
- `oss-fuzz/` — local OSS-Fuzz workflow used to build and run the target in Docker
- `seed_corpus/` — valid PNG files used to help the fuzzer reach real parsing paths
- `scripts/` — helper scripts for build, fuzzing, reproduction, and regression testing
- `project4_fuzzing_assignment.tex` — LaTeX source for the assignment handout
- `project4_fuzzing_assignment.pdf` — compiled assignment handout

## Quick Start

From the repository root:

```bash
./scripts/build.sh
./scripts/fuzz.sh 30
```

To reproduce a specific input:

```bash
./scripts/reproduce.sh seed_corpus/pngnow.png
```

After fixing the required bugs, run:

```bash
./scripts/test_valid.sh
```

## What Students Should Edit

Students should implement their fixes in:

```text
libpng-course/course/course_vuln.c
```

Students should not replace the target or substantially rewrite the provided fuzzing infrastructure.

## Submission Overview

Students should submit:

- a patched `course_vuln.c` file or a patch/diff
- a short writeup
- a `reproducers/` folder containing two reproducing inputs, one for each bug fixed

## Notes

- The provided workflow uses Docker and the local OSS-Fuzz setup.
- Native local builds outside the provided workflow are not supported.
- The provided seed corpus is installed automatically by `./scripts/build.sh`.
