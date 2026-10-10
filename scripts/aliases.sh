#!/usr/bin/env bash

cat > "$HOME/.bash_aliases" <<'EOF'
alias rm='cd $HOME/nixos-sync/maintenance/ && ./safely-remove.sh'
alias vi='cd $HOME/nixos-sync/maintenance/ && ./remove-viminfo.sh'
alias ru='cd $HOME/nixos-sync/maintenance/ && ./rebuild-upgrade.sh'
alias rs='cd $HOME/nixos-sync/maintenance/ && ./rebuild-switch.sh'
alias rb='cd $HOME/nixos-sync/maintenance/ && ./rebuild-boot.sh'
EOF