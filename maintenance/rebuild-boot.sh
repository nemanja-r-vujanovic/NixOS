#!/usr/bin/env bash

sudo nix-env --profile "/nix/var/nix/profiles/system" --delete-generations +3
sudo nix-collect-garbage
sudo nixos-rebuild boot