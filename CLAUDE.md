# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal NixOS system configuration and dotfiles repository. Manages system-level NixOS configuration alongside user dotfiles.

## Deployment Commands

```bash
# Full system deploy: copy configs to /etc/nixos and rebuild NixOS
./deploy.sh

# Deploy only home/user configs (no rebuild needed)
./deploy-config.sh
```

## Architecture

- **configuration.nix** - Main NixOS system configuration (packages, services, boot, shell)
- **hardware-configuration.nix** - Auto-generated hardware config (do not manually edit)
- **home/** - User dotfiles deployed to ~/ and ~/.config/
  - `.gitconfig` - Git configuration
  - `.config/alacritty/alacritty.toml` - Terminal config (Catppuccin Mocha theme, auto-copy on select)
  - `.config/hypr/hyprland.conf` - Hyprland window manager keybindings

## Stack

- NixOS 25.11 with flakes enabled
- Hyprland (Wayland compositor) + waybar
- Alacritty + tmux + zsh (oh-my-zsh with autosuggestions)
- walker (application launcher)
- nix-ld for pre-built binaries (Claude, etc.)
