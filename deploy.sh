#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Linking NixOS configuration to /etc/nixos/..."
sudo ln -sfn "$SCRIPT_DIR/configuration.nix" /etc/nixos/configuration.nix
sudo ln -sfn "$SCRIPT_DIR/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
sudo ln -sfn "$SCRIPT_DIR/nvidia.nix" /etc/nixos/nvidia.nix

echo "Linking home configuration files..."
"$SCRIPT_DIR/deploy-config.sh"

echo "Rebuilding NixOS..."
sudo nixos-rebuild switch --flake .#nixos

echo "Deployment complete!"
