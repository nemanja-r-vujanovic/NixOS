#!/usr/bin/env bash

echo -e "\nReboot now?"
echo -n "Type NO to abort: "
read rboot

rboot_upper=$(echo "$rboot" | tr '[:lower:]' '[:upper:]')

if [[ "$rboot_upper" == "NO" ]]; then
	echo -e "\nReboot aborted!"
	exit 1
fi

systemctl reboot
