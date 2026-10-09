#!/usr/bin/env bash

# Similar to "sudo pacman -Syu" on Arch or "sudo apt update && sudo apt full-upgrade" on Debian
sudo nixos-rebuild switch --upgrade