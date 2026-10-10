#!/usr/bin/env bash

echo 'PS1="${PS1#\\n}"' >> "$HOME/.bashrc"
source "$HOME/.bashrc"