#!/usr/bin/env bash

set -euo pipefail

repo="${1:-memohai/Memoh}"
branch="${2:-main}"

curl -fsSL "https://api.github.com/repos/${repo}/commits/${branch}" | jq -r '.sha'
