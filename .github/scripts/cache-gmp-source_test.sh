#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "$0")/../.." && pwd)"
script="$repo_root/.github/scripts/cache-gmp-source.sh"
test_root="$(mktemp -d)"
cleanup() {
  rm -rf "$test_root"
}
trap cleanup EXIT

payload="$test_root/payload"
printf 'verified GNU source' >"$payload"
checksum="$(shasum -a 256 "$payload" | awk '{print $1}')"

write_mocks() {
  local fixture_dir="$1"
  mkdir -p "$fixture_dir/bin"
  cat >"$fixture_dir/bin/brew" <<'EOF'
#!/usr/bin/env bash
if [[ "$1 $2" == "info --json=v2" ]]; then
  printf '%s\n' "$GMP_METADATA"
else
  printf '%s\n' "$GMP_CACHE_PATH"
fi
EOF
  cat >"$fixture_dir/bin/curl" <<'EOF'
#!/usr/bin/env bash
printf '%s\n' "$*" >"$GMP_CURL_ARGS"
output=""
while [[ $# -gt 0 ]]; do
  if [[ "$1" == "--output" ]]; then
    output="$2"
    shift 2
  else
    shift
  fi
done
cp "$GMP_PAYLOAD" "$output"
EOF
  chmod +x "$fixture_dir/bin/brew" "$fixture_dir/bin/curl"
}

metadata() {
  local source_url="$1"
  local source_checksum="$2"
  printf '{"formulae":[{"versions":{"stable":"6.3.0"},"urls":{"stable":{"url":"%s","checksum":"%s"}}}]}' \
    "$source_url" "$source_checksum"
}

run_fixture() {
  local fixture_dir="$1"
  GMP_METADATA="$2" \
    GMP_CACHE_PATH="$fixture_dir/cache/gmp-6.3.0.tar.xz" \
    GMP_PAYLOAD="$payload" \
    GMP_CURL_ARGS="$fixture_dir/curl-args" \
    PATH="$fixture_dir/bin:$PATH" \
    "$script"
}

assert_temporary_source_is_removed() {
  local fixture_dir="$1"
  if [[ -d "$fixture_dir/cache" ]]; then
    test -z "$(find "$fixture_dir/cache" -name '.gmp-source.*' -print -quit)"
  fi
}

success_fixture="$test_root/success"
write_mocks "$success_fixture"
test ! -d "$success_fixture/cache"
run_fixture "$success_fixture" "$(metadata 'https://ftpmirror.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz' "$checksum")"
test -f "$success_fixture/cache/gmp-6.3.0.tar.xz"
cmp "$payload" "$success_fixture/cache/gmp-6.3.0.tar.xz"
grep -F 'https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz' "$success_fixture/curl-args"
grep -F -- '--max-time 180' "$success_fixture/curl-args"
assert_temporary_source_is_removed "$success_fixture"

metadata_fixture="$test_root/metadata"
write_mocks "$metadata_fixture"
if run_fixture "$metadata_fixture" "$(metadata 'https://example.invalid/gmp-6.3.0.tar.xz' "$checksum")"; then
  echo "expected unexpected formula metadata to fail" >&2
  exit 1
fi
test ! -e "$metadata_fixture/curl-args"
assert_temporary_source_is_removed "$metadata_fixture"

checksum_fixture="$test_root/checksum"
write_mocks "$checksum_fixture"
if run_fixture "$checksum_fixture" "$(metadata 'https://ftpmirror.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz' "$(printf '%064d' 0)")"; then
  echo "expected checksum mismatch to fail" >&2
  exit 1
fi
test ! -e "$checksum_fixture/cache/gmp-6.3.0.tar.xz"
assert_temporary_source_is_removed "$checksum_fixture"
