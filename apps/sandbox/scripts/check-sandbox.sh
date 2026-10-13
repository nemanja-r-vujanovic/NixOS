#!/usr/bin/env bash
set -euo pipefail

sleep 2

firejail --join=sandbox mkdir -p "$HOME/Downloads/"

if ! firejail --list | grep -q "sandbox"; then
	notify-send "Cannot find sandbox!"
fi