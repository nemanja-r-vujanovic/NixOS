#!/usr/bin/env bash

sudo vim "/etc/nixos/configuration.nix"
sudo nixos-rebuild switch

cd "$HOME/nixos-sync/maintenance/"
./"reboot-prompt.sh"
