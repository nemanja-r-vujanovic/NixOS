#!/usr/bin/env bash
set -euo pipefail

cat > "$HOME/.bash_aliases" <<'EOF'
alias cc='bash "clean-junk.sh"'
alias rm='bash "safely-remove.sh"'
alias rv='bash "remove-viminfo.sh"'
alias rd='bash "rebuild-dry.sh"'
alias rs='bash "rebuild-switch.sh"'
alias ru='bash "rebuild-upgrade.sh"'
alias rb='bash "rebuild-boot.sh"'
alias rp='bash "reboot-prompt.sh"'
EOF
