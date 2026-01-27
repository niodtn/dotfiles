#!bin/sh

TARGET_DISK="/dev/vda"

sudo parted "$TARGET_DISK" --script \
  mklabel gpt \
  mkpart primary fat32 1MiB 512MiB \
  set 1 esp on \
  mkpart primary ext4 512MiB 100%

sudo mkfs.fat -F 32 -n boot /dev/vda1
sudo mkfs.ext4 -L nixos /dev/vda2

sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot

sudo mkdir -p /mnt/tmp
cd /mnt/tmp

sudo nix-shell -p git --run "git clone https://github.com/niodtn/dotfiles"
cd dotfiles
sudo nixos-install --root /mnt --flake .#utm
