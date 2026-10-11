#!/usr/bin/env bash
set -euo pipefail

sudo nix-env --profile "/nix/var/nix/profiles/system" --delete-generations +3
sudo nix-collect-garbage
sudo nixos-rebuild boot

cd "$HOME/nixos-sync/maintenance/"
./"reboot-prompt.sh"