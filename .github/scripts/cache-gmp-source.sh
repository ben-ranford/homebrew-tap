#!/usr/bin/env bash

set -euo pipefail

metadata="$(brew info --json=v2 gmp)"
{
  IFS= read -r version
  IFS= read -r source_url
  IFS= read -r checksum
} < <(ruby -rjson -e '
  formula = JSON.parse(STDIN.read).fetch("formulae").fetch(0)
  puts formula.fetch("versions").fetch("stable")
  puts formula.fetch("urls").fetch("stable").fetch("url")
  puts formula.fetch("urls").fetch("stable").fetch("checksum")
' <<<"$metadata")
expected_source_url="https://ftpmirror.gnu.org/gnu/gmp/gmp-${version}.tar.xz"

if [[ ! "$version" =~ ^[0-9]+(\.[0-9]+)+$ ]] ||
  [[ "$source_url" != "$expected_source_url" ]] ||
  [[ ! "$checksum" =~ ^[[:xdigit:]]{64}$ ]]; then
  echo "Unexpected Homebrew GMP source metadata; refusing to prefetch." >&2
  exit 1
fi

cache_path="$(brew --cache --build-from-source gmp)"
cache_dir="$(dirname "$cache_path")"
mkdir -p "$cache_dir"
temp_path="$(mktemp "${cache_dir}/.gmp-source.XXXXXX")"
cleanup() {
  rm -f "$temp_path"
}
trap cleanup EXIT

curl --fail --location --retry 3 --connect-timeout 15 --max-time 180 \
  "https://ftp.gnu.org/gnu/gmp/gmp-${version}.tar.xz" \
  --output "$temp_path"

actual_checksum="$(shasum -a 256 "$temp_path" | awk '{print $1}')"
if [[ "$actual_checksum" != "$checksum" ]]; then
  echo "GNU GMP source checksum does not match Homebrew formula metadata." >&2
  exit 1
fi

mv "$temp_path" "$cache_path"
trap - EXIT
