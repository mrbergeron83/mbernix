#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up symlinks..."
echo ""

# System NixOS configuration symlinks
echo "=== System configuration (requires sudo) ==="
sudo ln -sfn "$SCRIPT_DIR/configuration.nix" /etc/nixos/configuration.nix
sudo ln -sfn "$SCRIPT_DIR/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
sudo ln -sfn "$SCRIPT_DIR/nvidia.nix" /etc/nixos/nvidia.nix
echo "Linked NixOS configs to /etc/nixos/"

echo ""
echo "=== User configuration ==="

# Remove existing configs and create symlinks
# .config directories
for dir in "$SCRIPT_DIR"/home/.config/*/; do
    if [ -d "$dir" ]; then
        dirname=$(basename "$dir")
        target="$HOME/.config/$dirname"

        # Remove existing (file, symlink, or directory)
        if [ -e "$target" ] || [ -L "$target" ]; then
            rm -rf "$target"
        fi

        ln -sfn "$dir" "$target"
        echo "Linked ~/.config/$dirname"
    fi
done

# Dotfiles in home root
for file in "$SCRIPT_DIR"/home/.*; do
    basename=$(basename "$file")
    # Skip . and .. and .config
    if [ "$basename" = "." ] || [ "$basename" = ".." ] || [ "$basename" = ".config" ]; then
        continue
    fi

    target="$HOME/$basename"

    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -rf "$target"
    fi

    ln -sfn "$file" "$target"
    echo "Linked ~/$basename"
done

echo ""
echo "Symlinks created! Changes to files in this repo will now take effect immediately."
echo "You still need to run 'sudo nixos-rebuild switch' after changing NixOS configs."
