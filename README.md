# mbernix

Personal NixOS configuration and dotfiles.

## Stack

- **OS:** NixOS 25.11 with flakes
- **Window Manager:** Hyprland (Wayland) + waybar
- **Terminal:** Alacritty + tmux + zsh (oh-my-zsh)
- **Launcher:** walker
- **Theme:** Catppuccin Mocha

## Usage

### Full System Deploy

Copies configuration to `/etc/nixos/` and rebuilds NixOS:

```bash
./deploy.sh
```

### User Config Only

Deploys dotfiles from `home/` to `~/` without system rebuild:

```bash
./deploy-config.sh
```

## Structure

```
.
├── configuration.nix      # NixOS system configuration
├── hardware-configuration.nix  # Hardware config (auto-generated)
├── deploy.sh              # Full system deploy script
├── deploy-config.sh       # User config deploy script
└── home/                  # User dotfiles
    ├── .gitconfig
    └── .config/
        ├── alacritty/
        └── hypr/
```

## Hyprland Keybindings

| Key | Action |
|-----|--------|
| Super + Return | Terminal (Alacritty) |
| Super + 0 | App launcher (walker) |
| Super + Q | Close window |
| Super + Shift + M | Exit Hyprland |
