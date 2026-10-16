#!/usr/bin/env bash
set -euo pipefail

sudo nix-env --profile "/nix/var/nix/profiles/system/" --delete-generations +3
sudo nix-collect-garbage
sudo nixos-rebuild boot

bash "$HOME/nixos-sync/maintenance/confirm-reboot.sh"
