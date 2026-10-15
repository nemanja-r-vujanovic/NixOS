#!/usr/bin/env bash
set -euo pipefail

notify-send -t 3000 "Sandbox is running."

/run/wrappers/bin/firejail \
  --dns=8.8.8.8 \
  --name=sandbox \
  --profile=chromium-browser \
  --private \
  $(readlink -f $(command -v chromium)) \
  --no-remote \
  --password-store=basic \
  --no-first-run

bash "$HOME/nixos-sync/apps/sandbox/scripts/check-sandbox.sh"
