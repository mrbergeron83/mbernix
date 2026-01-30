# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal NixOS system configuration and dotfiles repository. Manages system-level NixOS configuration alongside user dotfiles with bidirectional sync between the repository and live system.

## Deployment Commands

```bash
# Full deployment: copy configs to /etc/nixos, deploy home configs, rebuild system
./deploy.sh deploy

# Deploy only home directory configs (no system rebuild)
./deploy.sh home

# Pull live system configs back into repository
./deploy.sh pull

# Show diff between repository and live system
./deploy.sh diff
```

## Quick Reload (Development)

```bash
# Rebuild NixOS only
./reload.sh nixos

# Hot reload Hyprland config only (no rebuild)
./reload.sh hypr

# Both (default)
./reload.sh all
```

## Architecture

- **configuration.nix** - Main NixOS system configuration (packages, services, boot)
- **hardware-configuration.nix** - Auto-generated hardware config (do not manually edit)
- **home/** - User dotfiles deployed to ~/ and ~/.config/
  - `.gitconfig` - Git configuration
  - `.config/alacritty/alacritty.toml` - Terminal config (Catppuccin Mocha theme)
  - `.config/hypr/hyprland.conf` - Hyprland window manager keybindings

## Stack

- NixOS 25.11 with flakes enabled
- Hyprland (Wayland compositor) + waybar
- Alacritty + tmux + zsh (oh-my-zsh with autosuggestions)
- walker (application launcher)
- nix-ld for pre-built binaries (Claude, etc.)

## Workflow

1. Modify configs in this repository
2. Test with `./reload.sh hypr` for fast Hyprland iteration
3. Full rebuild with `./deploy.sh deploy`
4. Use `./deploy.sh pull` to capture any live system changes back to repo
