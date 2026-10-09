#!/usr/bin/env bash
set -euo pipefail

# 1. Superuser:
if (( EUID != 0 )); then
	echo "Run this script as root!"
	exit 1
fi

# 2. Font:
setfont ter-132b
loadkeys sr-latin

# 3. Connection:
if ping -qc 1 "www.google.com" > /dev/null 2>&1; then
	echo "Network: already connected."
else
	echo "Network: not connected!"
	echo "Connect using nmtui, then restart the script."
	exit 1
fi

# 4. Clear screen:
clear                          # Ctrl + L

# 5. List partitions:
lsblk

# 6. Create partitions:
if [[ ! -d /sys/firmware/efi ]]; then
	echo "UEFI mode required!"
	exit 1
fi

echo -n "Enter disk (example: /dev/sda or /dev/nvme0n1): "
read disk

echo -e "\nWARNING: ALL DATA ON $disk WILL BE DESTROYED!"
echo -n "Type Y to continue: "
read confirm

if [[ "Y" != "$confirm" && "y" != "$confirm" ]]; then
	echo "Aborted."
	exit 1
fi

wipefs -a "$disk"
parted --script "$disk" mklabel gpt

# Partitioning (GPT):
# EFI → Size: 512 MB → File System: fat32 → Mount Point: /boot/ → Label: boot → Flags: boot, esp
# Swap → Size: 4096 MB → File System: linux-swap → Label: swap
# Root → Size: Remaining MB → File System: ext4 → Mount Point: / → Label: nixos

# Size:
start="1"
efi="$((start + 512))"
swap="$((efi + 4096))"
root="100%"

# EFI:
parted --script "$disk" mkpart primary fat32 "$start"MiB "$efi"MiB
parted --script "$disk" name 1 "boot"
parted --script "$disk" set 1 boot on
parted --script "$disk" set 1 esp on

# Swap:
parted --script "$disk" mkpart primary linux-swap "$efi"MiB "$swap"MiB
parted --script "$disk" name 2 "swap"

# Root:
parted --script "$disk" mkpart primary ext4 "$swap"MiB "$root"MiB
parted --script "$disk" name 3 "nixos"

partprobe "$disk"
udevadm settle

# Partition device names (nvme uses p1, sata uses 1):
if [[ "$disk" =~ nvme|mmcblk ]]; then
	P1="${disk}p1"; P2="${disk}p2"; P3="${disk}p3"
else
	P1="${disk}1"; P2="${disk}2"; P3="${disk}3"
fi

# Format partitions:
mkfs.fat -F 32 -n "boot" "$P1" # EFI
mkswap -L "swap" "$P2"         # Swap
mkfs.ext4 -F -L "nixos" "$P3"  # Root

# Mount partitions:
mount -t ext4 "$P3" "/mnt/"
mount --mkdir "$P1" "/mnt/boot/"
swapon "$P2"

lsblk "$disk"                  # Show result

echo -e "\nPartitioning completed.\nInstallation starts in 15 seconds..."
sleep 15

# 7. Generate config:
nixos-generate-config --root "/mnt/"

# 8. Configure:
git clone "https://github.com/nemanja-r-vujanovic/NixOS.git" "/tmp/NixOS/"
mv "/tmp/NixOS/Configurations/configuration.nix" "/mnt/etc/nixos/"

# 9. Install:
nixos-install
# New password:
# Retype new password:

echo -n -e "\nEnter username from configuration.nix (example: user): "
read username
if (( "${#username}" < 1 )); then
	echo "Username is empty!"
	exit 1
fi

nixos-enter --root "/mnt/" -c "passwd $username"

# 10. Personal files:
mkdir -p "/mnt/home/$username/"
mv "/tmp/NixOS/" "/mnt/home/$username/"

rm -r "/mnt/home/$username/NixOS/Configurations/"
rm -r "/mnt/home/$username/NixOS/Shortcuts/"
rm "/mnt/home/$username/NixOS/README.md"
rm "/mnt/home/$username/NixOS/install.sh"
mv "/mnt/home/$username/NixOS/first-boot.md" "/mnt/home/$username/"
mv "/mnt/home/$username/NixOS/Scripts/" "/mnt/home/$username/"
mv "/mnt/home/$username/NixOS/Wallpapers/" "/mnt/home/$username/"
mv "/mnt/home/$username/NixOS/Maintenance/" "/mnt/home/$username/"

# Fix ownership:
nixos-enter --root "/mnt" -c "chown -R $username:users /home/$username/"

# 11. Poweroff:
swapoff -a
umount -R "/mnt"
systemctl poweroff
