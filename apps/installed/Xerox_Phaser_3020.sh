#!/usr/bin/env bash
set -euo pipefail

unzip "$HOME/nixos-sync/apps/installed/Xerox_Phaser_3020.zip"
rm "$HOME/nixos-sync/apps/installed/Xerox_Phaser_3020.zip"
chmod +x "$HOME/nixos-sync/apps/installed/Xerox_Phaser_3020/install-printer.sh"
sudo bash "$HOME/nixos-sync/apps/installed/Xerox_Phaser_3020/install-printer.sh"
rm -r "$HOME/nixos-sync/apps/installed/Xerox_Phaser_3020/"
