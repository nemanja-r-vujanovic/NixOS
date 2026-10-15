#!/bin/bash
set -euo pipefail

# Ventoy ...

rm "$HOME/.viminfo"

rm -r "$HOME/.copilot/"
rm -r "$HOME/thunderbird/"
rm -r "$HOME/ViberDownloads/PTT/"

if [[ -d "$HOME/.local/share/Trash/" ]]; then
	rm -r "$HOME/.local/share/Trash/files/"*
	rm -r "$HOME/.local/share/Trash/info/"*
fi
