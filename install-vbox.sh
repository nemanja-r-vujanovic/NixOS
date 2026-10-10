#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------------------------------------
# 1. CHECKS

# Superuser:
if (( EUID != 0 )); then
	echo "Run this script as root!"
	exit 1
fi

# Connection:
if ! ping -q -c 1 "www.google.com" > /dev/null 2>&1; then
	echo "Network: not connected!"
	exit 1
fi

# UEFI boot:
if [[ ! -d /sys/firmware/efi ]]; then
	echo "UEFI mode required!"
	exit 1
fi

# ------------------------------------------------------------------------------------------
# 2. FONT

setfont ter-132b
loadkeys sr-latin

# ------------------------------------------------------------------------------------------
# 3. CLEAR SCREEN

clear                          # Ctrl + L

# ------------------------------------------------------------------------------------------
# 4. LIST PARTITIONS

lsblk

# ------------------------------------------------------------------------------------------
# 5. INPUTS

# disk="/dev/sda"
# timezone="Europe/Belgrade"
# username="user"
# hostname="nixos"
# password="..."
# confirm_password="$password"
# confirm_install="YES"

# Disk:
echo -n -e "\nEnter disk (example: /dev/sda or /dev/nvme0n1): "
read disk

if [[ ! -b "$disk" ]]; then
	echo "'$disk' is not a block device!"
	exit 1
fi
if [[ "$(lsblk -d -n -o TYPE "$disk")" != "disk" ]]; then
	echo "'$disk' is not a whole disk!"
	exit 1
fi

# Timezone:
echo -n "Enter timezone (example: Europe/Belgrade): "
read timezone

if (( "${#timezone}" < 1 )); then
	echo "Timezone cannot be empty!"
	exit 1
fi
if [[ ! -e "/etc/zoneinfo/$timezone" && ! -e "/usr/share/zoneinfo/$timezone" ]]; then
	echo "Timezone not found: $timezone!"
	exit 1
fi

# Username:
echo -n "Enter username (example: user): "
read username

if (( "${#username}" < 1 )); then
	echo "Username cannot be empty!"
	exit 1
fi

# Hostname:
echo -n "Enter hostname (example: nixos): "
read hostname

if (( "${#hostname}" < 1 )); then
	echo "Hostname cannot be empty!"
	exit 1
fi

# Password:
echo -n "Enter password: "
read password

if (( "${#password}" < 1 )); then
	echo "Password cannot be empty!"
	exit 1
fi

# Confirm password:
echo -n "Confirm password: "
read confirm_password

if [[ "$confirm_password" != "$password" ]]; then
	echo "Passwords did not match!"
	exit 1
fi

# Confirm install:
echo -e "\nWARNING: ALL DATA ON $disk WILL BE LOST!"
echo -n "Type YES to continue: "
read confirm_install

confirm_upper=$(echo "$confirm_install" | tr '[:lower:]' '[:upper:]')

if [[ "$confirm_upper" == "YES" ]]; then
	echo -e "\nConfirmation received. Continuing installation..."
else
	echo -e "\nInstallation aborted!"
	exit 1
fi

# ------------------------------------------------------------------------------------------
# 6. DISK PARTITIONING

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

echo -e "\nPartitioning completed.\nInstallation starts in 10 seconds..."
sleep 10

# ------------------------------------------------------------------------------------------
# 7. GENERATE CONFIG

nixos-generate-config --root "/mnt/"

# ------------------------------------------------------------------------------------------
# 8. CONFIGURATION

git clone "https://github.com/nemanja-r-vujanovic/NixOS.git" "/tmp/NixOS/"

sed -i "s|TIMEZONE_TO_BE_CHANGED|$timezone|g" "/tmp/NixOS/configurations/configuration.nix"
sed -i "s|USERNAME_TO_BE_CHANGED|$username|g" "/tmp/NixOS/configurations/configuration.nix"
sed -i "s|HOSTNAME_TO_BE_CHANGED|$hostname|g" "/tmp/NixOS/configurations/configuration.nix"

mv "/tmp/NixOS/configurations/configuration.nix" "/mnt/etc/nixos/"

# ------------------------------------------------------------------------------------------
# 9. INSTALLATION

nixos-install --no-root-passwd
# nixos-install
# New password:
# Retype new password:

printf 'root:%s\n' "$password" | nixos-enter --root /mnt -c chpasswd
printf '%s:%s\n' "$username" "$password" | nixos-enter --root /mnt -c chpasswd
unset password confirm_password

# nixos-enter --root "/mnt/" -c "passwd $username"

# ------------------------------------------------------------------------------------------
# 10. PERSONAL FILES

mkdir -p "/mnt/home/$username/"
mv "/tmp/NixOS/" "/mnt/home/$username/"
mv "/mnt/home/$username/NixOS/first-boot.md" "/mnt/home/$username/"

mkdir -p "/mnt/home/$username/nixos-sync/"
mv "/mnt/home/$username/NixOS/scripts/" "/mnt/home/$username/nixos-sync/"
mv "/mnt/home/$username/NixOS/wallpapers/" "/mnt/home/$username/nixos-sync/"
mv "/mnt/home/$username/NixOS/maintenance/" "/mnt/home/$username/nixos-sync/"

chmod +x "/mnt/home/$username/nixos-sync/scripts/"*".sh"
chmod +x "/mnt/home/$username/nixos-sync/maintenance/"*".sh"

rm -r "/mnt/home/$username/NixOS/"

# Fix ownership:
nixos-enter --root "/mnt" -c "chown -R $username:users /home/$username/"

# ------------------------------------------------------------------------------------------
# 11. POWEROFF

swapoff -a
umount -R "/mnt"
systemctl poweroff

# ------------------------------------------------------------------------------------------
