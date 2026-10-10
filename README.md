# NixOS

## 1. https://nixos.org/download/
## 2. NixOS: the Linux distribution
## 3. Minimal ISO image (Download (64-bit Intel/AMD))

## 4. Bootable USB
### Ventoy:
* Ventoy install
* Copy / Paste
* Update

### dd:
* lsblk
* sudo dd if="nixos-minimal-x86_64.iso" of="/dev/sda" status=progress && systemctl poweroff

## 5. Boot in EFI
### UEFI Setup: F2
* Setup Defaults: F9
* Wireless LAN: Enabled
* Flip to Boot: Disabled
* Always On USB: Disabled
* Secure Boot: Disabled
* Boot Mode: UEFI
* USB Boot: Enabled
* Save and Exit: F10

### Boot Menu: F12
* Select: EFI USB Device

## 6. Font
* setfont ter-132b
* sudo loadkeys sr-latin

## 7. Installation:
* git clone "https://github.com/nemanja-r-vujanovic/NixOS.git"
* chmod +x "NixOS/install-vbox.sh"
* sudo ./"NixOS/install-vbox.sh"
