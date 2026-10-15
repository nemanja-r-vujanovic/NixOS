#!/usr/bin/env bash
set -euo pipefail

sleep 2

if ! "/run/wrappers/bin/firejail" --list | grep -q "sandbox"; then
	notify-send -t 15000 "Cannot find sandbox!"
else
	notify-send -t 3000 "Sandbox is running."
fi
