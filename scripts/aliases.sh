#!/usr/bin/env bash
set -euo pipefail

cat > "$HOME/.bash_aliases" <<'EOF'
alias rm='gio trash'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fls='bash "$HOME/nixos-sync/maintenance/list-sandboxed.sh"'
alias sr='bash "$HOME/nixos-sync/maintenance/restore-sandboxed.sh"'
alias cc='bash "$HOME/nixos-sync/maintenance/clean-junk.sh"'
alias rd='bash "$HOME/nixos-sync/maintenance/rebuild-dry.sh"'
alias rs='bash "$HOME/nixos-sync/maintenance/rebuild-switch.sh"'
alias ru='bash "$HOME/nixos-sync/maintenance/rebuild-upgrade.sh"'
alias rb='bash "$HOME/nixos-sync/maintenance/rebuild-boot.sh"'
alias rp='bash "$HOME/nixos-sync/maintenance/confirm-reboot.sh"'
EOF
