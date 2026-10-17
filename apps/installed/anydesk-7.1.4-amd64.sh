#!/usr/bin/env bash
set -euo pipefail

tar -xzf "$HOME/nixos-sync/apps/installed/anydesk-7.1.4-amd64.tar.gz"
rm "$HOME/nixos-sync/apps/installed/anydesk-7.1.4-amd64.tar.gz"
chmod +x "$HOME/nixos-sync/apps/installed/anydesk-7.1.4/install.sh"
sudo bash "$HOME/nixos-sync/apps/installed/anydesk-7.1.4/install.sh" --install
