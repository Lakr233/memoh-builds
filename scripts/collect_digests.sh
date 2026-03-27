#!/usr/bin/env bash

set -euo pipefail

owner="${1:?owner is required}"
short_sha="${2:?short sha is required}"
out_dir="${3:-digests}"

mkdir -p "${out_dir}"

owner="${owner,,}"
images=(server web browser sparse)

for image in "${images[@]}"; do
  ref="ghcr.io/${owner}/memoh-${image}:sha-${short_sha}"
  docker pull "${ref}" >/dev/null
  docker image inspect "${ref}" --format '{{index .RepoDigests 0}}' > "${out_dir}/${image}.txt"
done

jq -n \
  --arg server "$(cat "${out_dir}/server.txt")" \
  --arg web "$(cat "${out_dir}/web.txt")" \
  --arg browser "$(cat "${out_dir}/browser.txt")" \
  --arg sparse "$(cat "${out_dir}/sparse.txt")" \
  '{
    server: $server,
    web: $web,
    browser: $browser,
    sparse: $sparse
  }' > "${out_dir}/digests.json"
