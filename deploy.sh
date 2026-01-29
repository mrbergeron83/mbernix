#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

case "${1:-}" in
  deploy)
    echo "Deploying NixOS configuration..."
    sudo cp "$REPO_DIR/configuration.nix" /etc/nixos/configuration.nix
    sudo cp "$REPO_DIR/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
    cp "$REPO_DIR/hyprland.conf" ~/.config/hypr/hyprland.conf
    echo "Files copied. Rebuilding NixOS..."
    sudo nixos-rebuild switch
    echo "Deploy complete!"
    ;;
  pull)
    echo "Pulling system configs into repo..."
    sudo cp /etc/nixos/configuration.nix "$REPO_DIR/configuration.nix"
    sudo cp /etc/nixos/hardware-configuration.nix "$REPO_DIR/hardware-configuration.nix"
    cp ~/.config/hypr/hyprland.conf "$REPO_DIR/hyprland.conf"
    echo "System configs pulled into repo."
    ;;
  diff)
    echo "=== configuration.nix ==="
    diff -u /etc/nixos/configuration.nix "$REPO_DIR/configuration.nix" || true
    echo ""
    echo "=== hardware-configuration.nix ==="
    diff -u /etc/nixos/hardware-configuration.nix "$REPO_DIR/hardware-configuration.nix" || true
    echo ""
    echo "=== hyprland.conf ==="
    diff -u ~/.config/hypr/hyprland.conf "$REPO_DIR/hyprland.conf" || true
    ;;
  *)
    echo "Usage: $0 {deploy|pull|diff}"
    echo ""
    echo "  deploy  - Copy repo configs to system and rebuild NixOS"
    echo "  pull    - Copy system configs into repo (for backup)"
    echo "  diff    - Show differences between repo and system"
    exit 1
    ;;
esac
