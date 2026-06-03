#!/usr/bin/env bash
# Update Formula/octocode.rb to a published npm version: fetches the registry
# tarball, computes its sha256, and rewrites url + sha256 in the formula.
#
# Usage:  scripts/update-formula.sh 1.5.0
#         (defaults to the latest published version if no arg is given)
set -euo pipefail

VER="${1:-$(npm view octocode-cli version)}"
TARBALL="https://registry.npmjs.org/octocode-cli/-/octocode-cli-${VER}.tgz"
FORMULA="$(dirname "$0")/../Formula/octocode.rb"

echo "→ version: ${VER}"
echo "→ tarball: ${TARBALL}"

SHA="$(curl -fsSL "${TARBALL}" | shasum -a 256 | awk '{print $1}')"
echo "→ sha256:  ${SHA}"

# Portable in-place sed (works on both BSD/macOS and GNU sed).
sed -i.bak -E \
  -e "s|octocode-cli-[0-9]+\.[0-9]+\.[0-9]+\.tgz|octocode-cli-${VER}.tgz|" \
  -e "s|^( *sha256 )\".*\"|\1\"${SHA}\"|" \
  "${FORMULA}"
rm -f "${FORMULA}.bak"

echo "✓ updated ${FORMULA}"
echo "  Next: brew style ${FORMULA} && git commit -am \"octocode ${VER}\" && git push"
