#!/usr/bin/env bash
set -euo pipefail

sudo vim "/etc/nixos/configuration.nix"
sudo nixos-rebuild switch

cd "$HOME/nixos-sync/maintenance/"
./"reboot-prompt.sh"