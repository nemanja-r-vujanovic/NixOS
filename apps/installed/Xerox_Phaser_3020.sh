#!/usr/bin/env bash
set -euo pipefail

unzip "$HOME/nixos-sync/apps/installed/Xerox_Phaser_3020.zip"
rm "$HOME/nixos-sync/apps/installed/Xerox_Phaser_3020.zip"
sudo mv "$HOME/nixos-sync/apps/installed/Xerox_Phaser_3020/"* "/usr/share/fonts/"
rm -r "$HOME/nixos-sync/apps/installed/Xerox_Phaser_3020/"