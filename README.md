# mbernix

Personal NixOS configuration and dotfiles.

## Stack

- **OS:** NixOS 25.11 with flakes
- **Window Manager:** Hyprland (Wayland) + waybar
- **Terminal:** Alacritty + tmux + zsh (oh-my-zsh)
- **Launcher:** walker
- **Theme:** Catppuccin Mocha

## Setup

First-time setup creates symlinks and rebuilds NixOS:

```bash
./deploy.sh
```

After initial setup:
- **NixOS changes** (configuration.nix): `sudo nixos-rebuild switch`
- **Home configs** (hyprland, waybar, etc.): Changes apply immediately (symlinked)

## Structure

```
.
├── configuration.nix          # NixOS system configuration
├── hardware-configuration.nix # Hardware config (auto-generated)
├── nvidia.nix                 # NVIDIA GPU auto-detection
├── deploy.sh                  # Full system deploy (symlinks + rebuild)
├── deploy-config.sh           # User config symlinks only
└── home/                      # User dotfiles (symlinked to ~/)
    ├── .gitconfig
    ├── .zshrc
    └── .config/
        ├── alacritty/         # Terminal config
        ├── hypr/              # Hyprland config
        └── waybar/            # Taskbar config
```

## Hyprland Keybindings

| Key | Action |
|-----|--------|
| Super + Return | Terminal (Alacritty) |
| Super + Space | App launcher (walker) |
| Super + 0 | Microsoft Edge |
| Super + Q | Close window |
| Super + M | Minimize window |
| Super + V | Toggle floating |
| Super + Up | Maximize |
| Super + Shift + M | Exit Hyprland |
