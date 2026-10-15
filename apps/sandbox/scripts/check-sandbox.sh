#!/usr/bin/env bash
set -euo pipefail

sleep 2

if ! "/run/wrappers/bin/firejail" --list | grep -q "sandbox"; then
	notify-send "Cannot find sandbox!"
fi
