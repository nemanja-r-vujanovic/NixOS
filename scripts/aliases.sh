#!/usr/bin/env bash
set -euo pipefail

cat > "$HOME/.bash_aliases" <<'EOF'
alias cc='bash "$HOME/nixos-sync/maintenance/"clean-junk.sh"'
alias rm='bash "$HOME/nixos-sync/maintenance/safely-remove.sh"'
alias rv='bash "$HOME/nixos-sync/maintenance/remove-viminfo.sh"'
alias rd='bash "$HOME/nixos-sync/maintenance/rebuild-dry.sh"'
alias rs='bash "$HOME/nixos-sync/maintenance/rebuild-switch.sh"'
alias ru='bash "$HOME/nixos-sync/maintenance/rebuild-upgrade.sh"'
alias rb='bash "$HOME/nixos-sync/maintenance/rebuild-boot.sh"'
alias rp='bash "$HOME/nixos-sync/maintenance/reboot-prompt.sh"'
EOF
