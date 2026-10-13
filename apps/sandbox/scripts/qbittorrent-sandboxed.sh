#!/usr/bin/env bash
set -euo pipefail

firejail --dns=8.8.8.8 --name=sandbox --private qbittorrent &

bash "$HOME/nixos-sync/apps/sandbox/scripts/check-sandbox.sh"