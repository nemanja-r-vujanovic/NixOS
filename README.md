# NixOS

## 1. https://nixos.org/download/
## 2. NixOS: the Linux distribution
## 3. Minimal ISO image (Download (64-bit Intel/AMD))
## 4. Boot in EFI

## 5. Font:
* setfont ter-132b
* sudo loadkeys sr-latin

## 6. Installation:
* git clone "https://github.com/nemanja-r-vujanovic/NixOS.git"
* cd "NixOS/"
* chmod +x *".sh"
* sudo ./"install.sh"

## 7. First boot:
* Super + D
* alacritty
* Ctrl + +
* git clone "https://github.com/nemanja-r-vujanovic/NixOS.git"
* cd "$HOME/NixOS/"
* chmod +x *".sh"
* ./"1_run.sh"

## 8. Maintenance:
* sudo vim "/etc/nixos/configuration.nix"
    * sudo nixos-rebuild switch

* sudo nix-env --profile "/nix/var/nix/profiles/system" --delete-generations +3
    * sudo nix-collect-garbage
    * sudo nixos-rebuild boot

* sudo nixos-rebuild switch --upgrade # Similar to "sudo pacman -Syu" on Arch
