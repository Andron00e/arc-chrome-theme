#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KEY="$ROOT/keys/arcify-custom-colors.pem"

build() {
  local name="$1" test_script="$2" label="$3" key="${4:-}"
  local work="$ROOT/build/$name"
  local out="$ROOT/dist/$name"

  echo "==> $name"
  rm -rf "$work" "$out"
  mkdir -p "$work" "$ROOT/dist"
  git -C "$ROOT/vendor/$name" archive HEAD | tar -x -C "$work"
  git -C "$work" init -q
  git -C "$work" apply "$ROOT/patches/$name.patch"
  (
    cd "$work"
    PUPPETEER_SKIP_DOWNLOAD=1 npm ci --no-audit --no-fund --loglevel=error
    [[ -n "${SKIP_TESTS:-}" ]] || npm run --silent "$test_script"
    npm run --silent build
  )
  cp -R "$work/dist" "$out"
  node "$ROOT/scripts/set-manifest.js" "$out/manifest.json" "$label" ${key:+"$key"}
}

git -C "$ROOT" submodule update --init

if [[ ! -f "$KEY" ]]; then
  mkdir -p "$(dirname "$KEY")"
  openssl genrsa -out "$KEY" 2048 2>/dev/null
fi

build arcify test:unit "(custom colors)" "$KEY"
build arcify-spotlight test "(recent tabs)"

echo "==> Load unpacked in chrome://extensions: dist/arcify and dist/arcify-spotlight"
