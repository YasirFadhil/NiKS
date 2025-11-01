# NixOS Configuration

A well-organized NixOS configuration with Home Manager integration.

## Structure

```
/etc/nixos/
├── flake.nix                     # Main flake configuration
├── flake.lock                    # Lock file for reproducible builds
├── configuration.nix             # Main NixOS configuration
├── hardware-configuration.nix    # Hardware-specific configuration
├── README.md                     # This file

├── nixos/                        # SYSTEM-WIDE config modules (NixOS)
│   ├── system/                   # Core system configurations
│   │   ├── audio.nix            # Audio/sound configuration
│   │   ├── network.nix          # Network settings
│   │   ├── users.nix            # User account management
│   │   ├── system-package.nix   # System-wide packages
│   │   ├── display.nix          # Display/graphics configuration
│   │   ├── gdm.nix              # GNOME Display Manager
│   │   ├── samba.nix            # Samba file sharing
│   │   ├── firejail.nix         # Application sandboxing
│   │   ├── virtual.nix          # Virtualization settings
│   │   ├── power-btn.nix        # Power button configuration
│   │   └── var-conf.nix         # Variable configurations
│   └── services/                # System services
│       └── dconf.nix            # DConf configuration service

└── home/                        # HOME MANAGER configurations
    ├── home.nix                 # Main Home Manager configuration
    ├── var.nix                  # Home Manager variables
    ├── nh.nix                   # NH (NixOS Helper) configuration
    ├── package.nix              # User packages

    ├── systems/                 # Desktop environments & window managers
    │   ├── hypr/                # Hyprland configuration
    │   │   ├── animation.nix    # Animation settings
    │   │   ├── binds.nix        # Keybindings
    │   │   ├── env.nix          # Environment variables
    │   │   ├── hypridle.nix     # Idle management
    │   │   ├── hyprland.nix     # Main Hyprland config
    │   │   ├── hyprlock.nix     # Screen locker
    │   │   ├── hyprpaper.nix    # Wallpaper manager
    │   │   └── polkitagent.nix  # PolicyKit agent
    │   ├── waybar/              # Status bar configuration
    │   ├── hyprpanel/           # Alternative panel
    │   └── nwg-dock/            # Application dock

    ├── programs/                # Applications & terminal tools
    │   ├── kitty/               # Kitty terminal emulator
    │   ├── ghostty/             # Ghostty terminal emulator
    │   ├── nus/                 # Nushell configuration
    │   │   ├── config.nu        # Nushell config
    │   │   ├── env.nu           # Environment setup
    │   │   └── starship.nix     # Starship prompt
    │   ├── zed/                 # Zed editor
    │   ├── fastfetch/           # System information tool
    │   ├── anyrun/              # Application launcher
    │   ├── rofi-launch/         # Rofi launcher configuration
    │   ├── spicetify/           # Spotify customization
    │   ├── ulauncher/           # Alternative launcher
    │   └── zenn/                # Zenn configuration

    ├── scripts/                 # Custom shell scripts
    │   ├── battery.nix          # Battery status scripts
    │   ├── volume.nix           # Volume control scripts
    │   ├── nowplay.nix          # Now playing display
    │   └── dunst.nix            # Notification scripts

    └── themes/                  # Visual customization
        ├── gtk/                 # GTK theme configuration
        ├── qt/                  # Qt theme configuration  
        ├── font/                # Font configuration
        ├── var/                 # Theme variables
        └── pict/                # Images & wallpapers
```

## Usage

1. **System Configuration**: Edit files in `nixos/system/` for system-wide changes
2. **Services**: Add new services in `nixos/services/`
3. **User Environment**: Modify files in `home/` for user-specific configurations
4. **Desktop Environment**: Configure window managers in `home/systems/`
5. **Applications**: Add or modify program configs in `home/programs/`
6. **Theming**: Customize appearance through files in `home/themes/`

## Building

```bash
# Rebuild system configuration
sudo nixos-rebuild switch --flake .

# Update only home manager
home-manager switch --flake .

# Update flake inputs
nix flake update
```

## Notes

- All system-wide configurations are in the `nixos/` directory
- User-specific configurations are managed through Home Manager in `home/`
- Images and wallpapers are stored in `home/themes/pict/`
- Custom scripts are organized in `home/scripts/`
