#!/usr/bin/env bash
fname="$(date -I)-${RANDOM}.png"
if [ ! -f "${HOME}/.cache/screenshot/" ]; then  
  mkdir -p "${HOME}/.cache/screenshot/"
fi

grim -g "$(slurp)" - -t png | swappy -f - -o "${HOME}/.cache/screenshot/${fname}"
echo "https://up.ayew.host/direct/${fname}" | wl-copy 
curl --silent --upload-file -H "Linx-Expiry: 86400" "${HOME}/.cache/screenshot/${fname}" "https://up.ayew.host/upload/${fname}"

