#!/usr/bin/env python3
"""Check release-file sizes and hashes; this does not verify mathematics."""
from pathlib import Path
import hashlib
import json

root = Path(__file__).resolve().parent
manifest_name = "SHA256SUMS.json"
manifest = json.loads((root / manifest_name).read_text(encoding="utf-8"))
listed = (root / "PUBLIC_FILES.txt").read_text(encoding="utf-8").splitlines()
expected = set(listed) - {manifest_name}
if len(listed) != len(set(listed)) or manifest_name not in listed:
    raise SystemExit("FAIL: invalid or duplicated release inventory")
if set(manifest["files"]) != expected:
    raise SystemExit("FAIL: manifest and release inventory disagree")
for name in sorted(expected):
    rel = Path(name)
    if rel.is_absolute() or ".." in rel.parts:
        raise SystemExit(f"FAIL: unsafe path {name}")
    path = root / rel
    if not path.is_file() or path.is_symlink():
        raise SystemExit(f"FAIL: missing or non-regular file {name}")
    data = path.read_bytes()
    record = manifest["files"][name]
    if len(data) != record["bytes"] or hashlib.sha256(data).hexdigest() != record["sha256"]:
        raise SystemExit(f"FAIL: content mismatch {name}")
print(f"PASS: {len(expected)} file hashes and sizes; {len(listed)} files in release inventory")
print("Integrity only: no mathematical theorem or novelty claim is certified by these hashes.")
