#!/usr/bin/env bash
set -e

case "${1:-all}" in
  nixos)
    echo "Rebuilding NixOS..."
    sudo nixos-rebuild switch
    echo "NixOS reloaded!"
    ;;
  hypr)
    echo "Reloading Hyprland..."
    hyprctl reload
    echo "Hyprland reloaded!"
    ;;
  all)
    echo "Rebuilding NixOS..."
    sudo nixos-rebuild switch
    echo "Reloading Hyprland..."
    hyprctl reload
    echo "All reloaded!"
    ;;
  *)
    echo "Usage: $0 {nixos|hypr|all}"
    echo ""
    echo "  nixos  - Rebuild NixOS configuration"
    echo "  hypr   - Reload Hyprland config (no rebuild)"
    echo "  all    - Rebuild NixOS and reload Hyprland (default)"
    exit 1
    ;;
esac
