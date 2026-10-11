#!/usr/bin/env bash
set -euo pipefail

cat > "$HOME/.bash_aliases" <<'EOF'
alias rv='cd $HOME/nixos-sync/maintenance/ && ./remove-viminfo.sh'
alias rm='cd $HOME/nixos-sync/maintenance/ && ./safely-remove.sh'
alias rd='cd $HOME/nixos-sync/maintenance/ && ./rebuild-dry.sh'
alias rs='cd $HOME/nixos-sync/maintenance/ && ./rebuild-switch.sh'
alias ru='cd $HOME/nixos-sync/maintenance/ && ./rebuild-upgrade.sh'
alias rb='cd $HOME/nixos-sync/maintenance/ && ./rebuild-boot.sh'
alias rp='cd $HOME/nixos-sync/maintenance/ && ./reboot-prompt.sh'
EOF
