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
    # Skip . and .. and .config/.local (handled separately)
    [[ "$basename_item" == "." || "$basename_item" == ".." || "$basename_item" == ".config" || "$basename_item" == ".local" ]] && continue
    if [ -e "$item" ]; then
        echo "Linking $basename_item"
        ln -sfn "$item" "$TARGET_HOME/$basename_item"
    fi
done
shopt -u dotglob

# Ensure ~/.config exists
mkdir -p "$TARGET_HOME/.config"

# Symlink each item (file or directory) inside .config
for item in "$SOURCE_HOME/.config"/*; do
    if [ -e "$item" ]; then
        basename_item=$(basename "$item")
        echo "Linking .config/$basename_item"
        ln -sfn "$item" "$TARGET_HOME/.config/$basename_item"
    fi
done

# Symlink .local/share/applications (custom desktop entries)
if [ -d "$SOURCE_HOME/.local/share/applications" ]; then
    mkdir -p "$TARGET_HOME/.local/share"
    echo "Linking .local/share/applications"
    ln -sfn "$SOURCE_HOME/.local/share/applications" "$TARGET_HOME/.local/share/applications"
fi

echo ""
echo "Configuration files linked successfully!"
echo "Changes to repo files will now apply immediately."

