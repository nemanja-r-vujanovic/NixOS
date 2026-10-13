#!/usr/bin/env bash
set -euo pipefail

firejail --dns=8.8.8.8 --name=sandbox --private chromium --no-remote --password-store=basic --no-first-run &

bash "$HOME/nixos-sync/apps/sandbox/scripts/check-sandbox.sh"