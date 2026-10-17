#!/usr/bin/env bash
set -euo pipefail

unzip "$HOME/nixos-sync/apps/installed/ArealRNIDS-otf.zip"
rm "$HOME/nixos-sync/apps/installed/ArealRNIDS-otf.zip"
sudo mv "$HOME/nixos-sync/apps/installed/ArealRNIDS-otf/"* "/usr/share/fonts/"
rm -r "$HOME/nixos-sync/apps/installed/ArealRNIDS-otf/"