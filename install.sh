#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------------------------------------
# 1. CHECKS

# Superuser:
if (( EUID != 0 )); then
	echo "Run script as root!"
	exit 1
fi

# Connection:
if ! ping -q -c 1 "www.google.com" > /dev/null 2>&1; then
	echo "Connect to network!"
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

disk="/dev/sda"
timezone="Europe/Belgrade"
username="user"
hostname="nixos"
password="student"
confirm_password="$password"
confirm_install="YES"

# Disk:
echo -e -n "\nEnter disk (example: /dev/sda or /dev/nvme0n1): "
read disk

if (( "${#disk}" < 1 )); then
	echo "Disk cannot be empty!"
	exit 1
fi
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
if [[ ! -e "/etc/zoneinfo/$timezone" ]]; then
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
read -s password
echo

if (( "${#password}" < 6 )); then
	echo "Password is too short!"
	exit 1
fi

# Confirm password:
echo -n "Confirm password: "
read -s confirm_password
echo

if [[ "$confirm_password" != "$password" ]]; then
	echo "Passwords did not match!"
	exit 1
fi

# Confirm install:
echo -e "\nWARNING: ALL DATA ON $disk WILL BE LOST!"
echo -n "Type YES to continue: "
read confirm_install

confirm_install_upper=$(echo "$confirm_install" | tr '[:lower:]' '[:upper:]')

if [[ "$confirm_install_upper" == "YES" ]]; then
	echo -e "\nConfirmation received. Continuing installation..."
else
	echo -e "\nInstallation aborted!"
	exit 1
fi

unset confirm_install
unset confirm_install_upper

# ------------------------------------------------------------------------------------------
# 6. DISK PARTITIONING

wipefs -a "$disk"
parted --script "$disk" mklabel gpt

# Partitioning (GPT):
# EFI → Size: 512 MB → File System: fat32 → Mount Point: /boot/ → Label: efi → Flags: boot, esp
# BIOS → Size: 8 MB → File System: cleared/unformatted → Flags: bios_grub
# Swap → Size: 4096 MB → File System: linux-swap → Label: swap
# Local → Size: 2048 MB → File System: ntfs → Label: local → Flags: msftdata
# Root → Size: Remaining MB → File System: ext4 → Mount Point: / → Label: nixos

# Size:
start="1"
efi="$((512 + start))"
bios="$((8 + efi))"
swap="$((4096 + bios))"
locl="$((2048 + swap))"
root="100%"

# EFI:
parted --script "$disk" mkpart primary fat32 "$start"MiB "$efi"MiB
parted --script "$disk" name 1 "efi"
parted --script "$disk" set 1 boot on
parted --script "$disk" set 1 esp on

# BIOS:
parted --script "$disk" mkpart primary "$efi"MiB "$bios"MiB
parted --script "$disk" name 2 "bios"
parted --script "$disk" set 2 bios_grub on

# Swap:
parted --script "$disk" mkpart primary linux-swap "$bios"MiB "$swap"MiB
parted --script "$disk" name 3 "swap"

# Local:
parted --script "$disk" mkpart primary ntfs "$swap"MiB "$locl"MiB
parted --script "$disk" name 4 "local"
parted --script "$disk" set 4 msftdata on

# Root:
parted --script "$disk" mkpart primary ext4 "$locl"MiB "$root"MiB
parted --script "$disk" name 5 "nixos"

partprobe "$disk"
udevadm settle

# Partition device names (nvme uses p1, sata uses 1):
if [[ "$disk" =~ nvme|mmcblk ]]; then
	P1="${disk}p1"; P2="${disk}p2"; P3="${disk}p3"; P4="${disk}p4"; P5="${disk}p5"
else
	P1="${disk}1"; P2="${disk}2"; P3="${disk}3"; P4="${disk}4"; P5="${disk}5"
fi

# Format partitions:
mkfs.fat -F 32 -n "efi" "$P1" # EFI
wipefs -a "$P2"               # BIOS
mkswap -L "swap" "$P3"        # Swap
mkfs.ntfs -Q -L "local" "$P4" # Local
mkfs.ext4 -F -L "nixos" "$P5" # Root

# Mount partitions:
mount -t ext4 "$P5" "/mnt/"
mount --mkdir -o umask=0077 "$P1" "/mnt/boot/"
swapon "$P3"

lsblk "$disk"                  # Show result

echo -e "\nPartitioning completed.\nInstallation starts in 7 seconds..."
sleep 7

unset start
unset efi
unset bios
unset swap
unset locl
unset root
unset P1
unset P2
unset P3
unset P4
unset P5

# ------------------------------------------------------------------------------------------
# 7. GENERATE CONFIG

nixos-generate-config --root "/mnt/"

# ------------------------------------------------------------------------------------------
# 8. CONFIGURATION

git clone "https://github.com/nemanja-r-vujanovic/NixOS.git" "/tmp/NixOS/"

sed -i "s|DISK_TO_BE_CHANGED|$disk|g" "/tmp/NixOS/configurations/configuration.nix"
sed -i "s|TIMEZONE_TO_BE_CHANGED|$timezone|g" "/tmp/NixOS/configurations/configuration.nix"
sed -i "s|USERNAME_TO_BE_CHANGED|$username|g" "/tmp/NixOS/configurations/configuration.nix"
sed -i "s|HOSTNAME_TO_BE_CHANGED|$hostname|g" "/tmp/NixOS/configurations/configuration.nix"
sed -i "s|USERNAME_TO_BE_CHANGED|$username|g" "/tmp/NixOS/apps/sandbox/launchers/"*".desktop"

mv "/tmp/NixOS/configurations/configuration.nix" "/mnt/etc/nixos/"

unset disk
unset timezone
unset hostname

# ------------------------------------------------------------------------------------------
# 9. INSTALLATION

nixos-install --no-root-passwd

printf '%s:%s\n' "root" "$password" | nixos-enter --root /mnt -c chpasswd
printf '%s:%s\n' "$username" "$password" | nixos-enter --root /mnt -c chpasswd

unset password
unset confirm_password

# ------------------------------------------------------------------------------------------
# 10. PERSONAL FILES

mkdir -p "/mnt/home/$username/"
mv "/tmp/NixOS/" "/mnt/home/$username/"
mv "/mnt/home/$username/NixOS/first-boot.md" "/mnt/home/$username/"

mkdir -p "/mnt/home/$username/nixos-sync/"
mv "/mnt/home/$username/NixOS/scripts/" "/mnt/home/$username/nixos-sync/"
mv "/mnt/home/$username/NixOS/wallpapers/" "/mnt/home/$username/nixos-sync/"
mv "/mnt/home/$username/NixOS/maintenance/" "/mnt/home/$username/nixos-sync/"
mv "/mnt/home/$username/NixOS/apps/" "/mnt/home/$username/nixos-sync/"

chmod +x "/mnt/home/$username/nixos-sync/scripts/"*".sh"
chmod +x "/mnt/home/$username/nixos-sync/maintenance/"*".sh"
chmod +x "/mnt/home/$username/nixos-sync/apps/sandbox/scripts/"*".sh"
chmod +x "/mnt/home/$username/nixos-sync/apps/scripts/"*".sh"

rm -r "/mnt/home/$username/NixOS/"

# Fix ownership:
nixos-enter --root "/mnt" -c "chown -R $username:users /home/$username/"

unset username

# ------------------------------------------------------------------------------------------
# 11. POWEROFF

swapoff -a
umount -R "/mnt"
systemctl poweroff

# ------------------------------------------------------------------------------------------
