#!/usr/bin/env bash

set -e

echo "Copying configuration files to /etc/nixos/..."
sudo cp configuration.nix /etc/nixos/configuration.nix
sudo cp hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo cp nvidia.nix /etc/nixos/nvidia.nix

echo "Copying home configuration files..."
cp -r home/.config/* ~/.config/
cp home/.gitconfig ~/.gitconfig

echo "Deploying NixOS configuration..."
sudo nixos-rebuild switch --option experimental-features "nix-command flakes"

echo "Deployment complete!"
