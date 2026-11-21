#!/usr/bin/env bash
# One-time setup: downloads the site images from Squarespace and fills in your
# contact email. Run from this folder:  bash setup.sh
# (Run it BEFORE cancelling Squarespace — the images are pulled from its CDN.)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p images

CDN="https://images.squarespace-cdn.com/content/v1/68752a4e73db7e01b914eb69"
dl() { echo "  images/$1"; curl -fsSL "$CDN/$2" -o "images/$1"; }

echo "Downloading images…"
dl logo.png          "ccd5d24d-f6b1-48c9-8d15-3feb8b78feed/mble.png?format=500w"
dl logo-alt.png      "aa20e47c-f2d4-46ef-8f75-c19b22bc86a7/mble.png?format=500w"
dl favicon.ico       "b3ebb5ba-2f8f-41ab-b27b-7688356c31aa/favicon.ico"
dl pkg-trial.jpg     "c6ae2238-ca7f-43e7-a881-da3fe759fb86/1.jpg?format=750w"
dl pkg-payg.jpg      "c25b38fa-fa76-4385-bba3-f6e6a05ff544/2.jpg?format=750w"
dl pkg-launch.jpg    "ffe0dc39-0803-4752-bbc3-02d4dc3e3ee3/3.jpg?format=750w"

if grep -rqs "__CONTACT_EMAIL__" --include=*.html --include=*.js .; then
  read -rp "Contact email to show on the site: " EMAIL
  grep -rls "__CONTACT_EMAIL__" --include=*.html --include=*.js . | while read -r f; do
    sed -i '' "s/__CONTACT_EMAIL__/${EMAIL}/g" "$f"
  done
  echo "Email set."
fi
echo "Done. Preview with:  python3 -m http.server 8000   then open http://localhost:8000"
