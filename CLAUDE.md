# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal NixOS system configuration and dotfiles repository. Manages system-level NixOS configuration alongside user dotfiles using symlinks.

## Deployment Commands

```bash
# First-time setup: creates symlinks and rebuilds NixOS
./deploy.sh

# After setup, for NixOS changes (configuration.nix):
sudo nixos-rebuild switch
```

## Architecture

- **configuration.nix** - Main NixOS system configuration (packages, services, boot, shell)
- **hardware-configuration.nix** - Auto-generated hardware config (do not manually edit)
- **nvidia.nix** - NVIDIA GPU auto-detection config
- **home/** - User dotfiles symlinked to ~/ and ~/.config/
  - `.gitconfig` - Git configuration
  - `.zshrc` - Zsh configuration
  - `.config/alacritty/alacritty.toml` - Terminal config (Catppuccin Mocha theme)

## Stack

- NixOS 25.11 with flakes enabled
- KDE Plasma 6 (Wayland) with SDDM
- Alacritty + tmux + zsh (oh-my-zsh with autosuggestions)
- Catppuccin Mocha theme throughout
- nix-ld for pre-built binaries (Claude, etc.)
