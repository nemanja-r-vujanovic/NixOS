# NixOS

## 1. https://nixos.org/download/
## 2. NixOS: the Linux distribution
## 3. Download (64-bit Intel/AMD)
## 4. Boot in EFI

## 5. Font:
* setfont ter-132b
* sudo loadkeys sr-latin

## 6. Connection:
* ping -c 3 www.google.com # Wi-Fi connection: nmtui

## 7. Superuser:
* sudo -i

## 8. Clear screen:
* clear                    # Ctrl + L

## 9. List partitions:
* lsblk

## 10. Create partitions:
* cfdisk /dev/sda
  	* Select label type: gpt

  	* New
  	* Partition size: 512M
  	* Type: EFI System

  	* New
  	* Partition size: 4G
  	* Type: Linux swap

  	* New
  	* Partition size: maxG
  	* Type: Linux filesystem

  	* Write → yes → Quit

## 11. Format partitions:
* mkfs.ext4 -L nixos /dev/sda3
* mkswap -L swap /dev/sda2
* mkfs.fat -F 32 -n boot /dev/sda1

## 12. Mount partitions:
* mount /dev/sda3 /mnt/
* mount --mkdir /dev/sda1 /mnt/boot/
* swapon /dev/sda2
* mount -t efivarfs efivarfs /sys/firmware/efi/efivarfs/

## 13. Verify partitions:
* lsblk

## 14. Generate config:
* nixos-generate-config --root /mnt/

## 15. Configure:
* nano /mnt/etc/nixos/configuration.nix
  	* See configuration.nix

## 16. Install:
* nixos-install
    * New password:
  	* Retype new password:
* nixos-enter --root /mnt/ -c 'passwd user'

## 17. Reboot:
reboot

## 18. Maintenance:
* sudo featherpad /etc/nixos/configuration.nix
* sudo nixos-rebuild switch
