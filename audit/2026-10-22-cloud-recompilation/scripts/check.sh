#!/usr/bin/env bash
# Usage: bash check.sh TOOLCHAIN_ROOT PACKAGES_DIR PROJECT_ROOT [LOG_DIR]
# PACKAGES_DIR contains the exact dependencies from lake-manifest.json,
# with compiled artifacts at PACKAGE/.lake/build/lib/lean.
# PROJECT_ROOT is the published partial-formalization directory (or an unchanged copy).
set -euo pipefail
if (( $# < 3 || $# > 4 )); then
  printf 'Usage: bash check.sh TOOLCHAIN_ROOT PACKAGES_DIR PROJECT_ROOT [LOG_DIR]\n' >&2
  exit 2
fi
toolchain=$(cd "$1" && pwd)
packages=$(cd "$2" && pwd)
project=$(cd "$3" && pwd)
logs=${4:-"$project/cloud-rerun-logs"}
mkdir -p "$logs"
logs=$(cd "$logs" && pwd)
export LEAN_NUM_THREADS=1
export LEAN_PATH="$project"
for pkg in "$packages"/*; do
  lib="$pkg/.lake/build/lib/lean"
  if [[ -d "$lib" ]]; then export LEAN_PATH="$LEAN_PATH:$lib"; fi
done
cd "$project"
"$toolchain/bin/lean" --version
: > "$logs/verify-summary.log"
for file in Zudilin/Basic.lean Zudilin/BaseCase.lean Zudilin/OriginalSum.lean Zudilin.lean AxiomAudit.lean IndependentAudit.lean ReviewChecks.lean; do
  log="$logs/${file//\//_}.log"
  set +e
  "$toolchain/bin/lean" -j 1 -s 131072 -DElab.async=false -o "${file%.lean}.olean" "$file" 2>&1 | tee "$log"
  result=${PIPESTATUS[0]}
  set -e
  printf 'exit_code=%s\n' "$result" | tee -a "$log"
  printf '%s: exit_code=%s\n' "$file" "$result" | tee -a "$logs/verify-summary.log"
  if (( result != 0 )); then exit "$result"; fi
done
