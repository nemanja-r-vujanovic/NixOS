#!/usr/bin/env bash

cat > "$HOME/.bashrc" <<'EOF'
PS1="${PS1#\\n}"

if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi
EOF

source "$HOME/.bashrc"
