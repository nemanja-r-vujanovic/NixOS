#!/usr/bin/env bash
set -euo pipefail

sudo tee "/etc/chromium/policies/managed/extensions.json" <<'EOF'
{
	"ExtensionSettings":
	{
		"ddkjiahejlhfcafbddmgiahcphecmpfh":
		{
			"update_url": "https://clients2.google.com/service/update2/crx",
			"installation_mode": "force_installed",
			"toolbar_pin": "force_pinned"
		}
	}
}
EOF
