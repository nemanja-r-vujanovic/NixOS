#!/usr/bin/env bash
set -euo pipefail

cat > "$HOME/.bash_aliases" <<'EOF'
alias cc='bash "$HOME/nixos-sync/maintenance/clean-junk.sh"'
alias rm='bash "$HOME/nixos-sync/maintenance/safe-remove.sh"'
alias rv='bash "$HOME/nixos-sync/maintenance/remove-viminfo.sh"'
alias rd='bash "$HOME/nixos-sync/maintenance/rebuild-dry.sh"'
alias rs='bash "$HOME/nixos-sync/maintenance/rebuild-switch.sh"'
alias ru='bash "$HOME/nixos-sync/maintenance/rebuild-upgrade.sh"'
alias rb='bash "$HOME/nixos-sync/maintenance/rebuild-boot.sh"'
alias rp='bash "$HOME/nixos-sync/maintenance/confirm-reboot.sh"'
alias sr='bash "$HOME/nixos-sync/maintenance/restore-sandboxed.sh"'
alias fls='bash "$HOME/nixos-sync/maintenance/list-sandboxed.sh"'
EOF
