#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_HOME="$SCRIPT_DIR/home"
TARGET_HOME="$HOME"

echo "Deploying user configuration files (symlinks)..."
echo "Source: $SOURCE_HOME"
echo "Target: $TARGET_HOME"
echo ""

# Symlink top-level dotfiles (.gitconfig, .zshrc, etc.)
shopt -s dotglob
for item in "$SOURCE_HOME"/.*; do
    basename_item=$(basename "$item")
    # Skip . and .. and .config (handled separately)
    [[ "$basename_item" == "." || "$basename_item" == ".." || "$basename_item" == ".config" ]] && continue
    if [ -e "$item" ]; then
        echo "Linking $basename_item"
        ln -sfn "$item" "$TARGET_HOME/$basename_item"
    fi
done
shopt -u dotglob

# Ensure ~/.config exists
mkdir -p "$TARGET_HOME/.config"

# Symlink each subdirectory inside .config
for item in "$SOURCE_HOME/.config"/*; do
    if [ -e "$item" ]; then
        basename_item=$(basename "$item")
        echo "Linking .config/$basename_item"
        ln -sfn "$item" "$TARGET_HOME/.config/$basename_item"
    fi
done

echo ""
echo "Configuration files linked successfully!"
echo "Changes to repo files will now apply immediately."
