#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_SRC="$REPO_DIR/home"

deploy_home() {
    echo "Deploying home configs..."

    # Ensure directories exist
    mkdir -p ~/.config/alacritty
    mkdir -p ~/.config/hypr

    # Copy home dotfiles
    [ -f "$HOME_SRC/.gitconfig" ] && cp "$HOME_SRC/.gitconfig" ~/.gitconfig

    # Copy .config directories
    cp -r "$HOME_SRC/.config/alacritty/." ~/.config/alacritty/
    cp -r "$HOME_SRC/.config/hypr/." ~/.config/hypr/

    echo "Home configs deployed!"
}

pull_home() {
    echo "Pulling home configs into repo..."

    # Ensure directories exist in repo
    mkdir -p "$HOME_SRC/.config/alacritty"
    mkdir -p "$HOME_SRC/.config/hypr"

    # Pull home dotfiles
    [ -f ~/.gitconfig ] && cp ~/.gitconfig "$HOME_SRC/.gitconfig"

    # Pull .config directories
    [ -f ~/.config/alacritty/alacritty.toml ] && cp ~/.config/alacritty/alacritty.toml "$HOME_SRC/.config/alacritty/"
    [ -f ~/.config/hypr/hyprland.conf ] && cp ~/.config/hypr/hyprland.conf "$HOME_SRC/.config/hypr/"

    echo "Home configs pulled!"
}

diff_home() {
    echo "=== .gitconfig ==="
    diff -u ~/.gitconfig "$HOME_SRC/.gitconfig" 2>/dev/null || true
    echo ""
    echo "=== alacritty.toml ==="
    diff -u ~/.config/alacritty/alacritty.toml "$HOME_SRC/.config/alacritty/alacritty.toml" 2>/dev/null || true
    echo ""
    echo "=== hyprland.conf ==="
    diff -u ~/.config/hypr/hyprland.conf "$HOME_SRC/.config/hypr/hyprland.conf" 2>/dev/null || true
}

case "${1:-}" in
  deploy)
    echo "Deploying NixOS configuration..."
    sudo cp "$REPO_DIR/configuration.nix" /etc/nixos/configuration.nix
    sudo cp "$REPO_DIR/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
    deploy_home
    echo "Rebuilding NixOS..."
    sudo nixos-rebuild switch
    echo "Deploy complete!"
    ;;
  home)
    deploy_home
    ;;
  pull)
    echo "Pulling system configs into repo..."
    sudo cp /etc/nixos/configuration.nix "$REPO_DIR/configuration.nix"
    sudo cp /etc/nixos/hardware-configuration.nix "$REPO_DIR/hardware-configuration.nix"
    pull_home
    echo "All configs pulled into repo."
    ;;
  diff)
    echo "=== configuration.nix ==="
    diff -u /etc/nixos/configuration.nix "$REPO_DIR/configuration.nix" || true
    echo ""
    echo "=== hardware-configuration.nix ==="
    diff -u /etc/nixos/hardware-configuration.nix "$REPO_DIR/hardware-configuration.nix" || true
    echo ""
    diff_home
    ;;
  *)
    echo "Usage: $0 {deploy|home|pull|diff}"
    echo ""
    echo "  deploy  - Deploy NixOS + home configs and rebuild"
    echo "  home    - Deploy only home configs (no rebuild)"
    echo "  pull    - Pull all system/home configs into repo"
    echo "  diff    - Show differences between repo and system"
    exit 1
    ;;
esac
