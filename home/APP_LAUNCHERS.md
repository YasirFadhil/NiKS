# App Launchers Configuration

This configuration provides multiple app launcher options for your Hyprland setup. You can choose between different launchers based on your preference.

## Available Launchers

### 1. Rofi (Default)
- **Keybind**: `SUPER + D`
- **Theme**: Custom macOS-inspired theme with OneDark colors
- **Features**:
  - Application launcher (`drun` mode)
  - Custom transparent design
  - JetBrains Mono Nerd Font
  - Icons support
  - Clipboard history integration (`SUPER + SHIFT + V`)

### 2. Ulauncher
- **Keybind**: `SUPER + SHIFT + D`
- **Theme**: Custom dark theme matching your color scheme
- **Features**:
  - Application launcher
  - Google search integration (keyword: `g`)
  - Calculator (keyword: `calc`)
  - Custom shortcuts
  - Auto-start service
  - Fuzzy search

### 3. Anyrun (Available but commented)
- **Keybind**: Currently disabled in binds.nix
- **Features**:
  - Multiple plugins (applications, shell, randr, rink, symbols, translate)
  - Shell commands with `>` prefix
  - Calculator with `=` prefix
  - Symbols with `:` prefix
  - Translate with `#` prefix

### 4. Launcher Switcher
- **Keybind**: `SUPER + CTRL + D`
- **Features**:
  - Interactive menu to switch between launchers
  - Command line interface
  - Automatic Hyprland config reload
  - Status display

## Switching Between Launchers

### Using the Launcher Switcher (Recommended)
Press `SUPER + CTRL + D` to open the interactive launcher switcher, or use command line:

```bash
# Interactive mode
launcher-switcher

# Quick switch commands
launcher-switcher rofi      # Switch to Rofi
launcher-switcher ulauncher # Switch to Ulauncher
launcher-switcher anyrun    # Switch to Anyrun
launcher-switcher status    # Show current launcher
```

### Manual Method
#### To use Ulauncher as default:
1. Edit `/etc/nixos/home/hypr/binds.nix`
2. Comment out the rofi line and uncomment ulauncher:
   ```nix
   # "SUPER, D, exec, rofi-launcher"
   "SUPER, D, exec, ulauncher-launcher"
   ```

#### To use Anyrun as default:
1. Edit `/etc/nixos/home/hypr/binds.nix`
2. Comment out the rofi line and uncomment anyrun:
   ```nix
   # "SUPER, D, exec, rofi-launcher"
   "SUPER, D, exec, anyrun"
   ```

## Configuration Files

### Rofi
- Main config: `home/rofi-launch/rasi.nix`
- Launcher script: `home/rofi-launch/launcher.nix`
- Color scheme: `home/rofi-launch/colors/onedark.rasi`

### Ulauncher
- Main config: `home/ulauncher/default.nix`
- Launcher script: `home/ulauncher/launcher.nix`
- Settings: Auto-generated in `~/.config/ulauncher/`
- Custom theme: `~/.config/ulauncher/user-themes/custom-dark/`

### Anyrun
- Main config: `home/anyrun/default.nix`
- Plugin configs: Auto-generated `.ron` files

## Customization

### Rofi Theme
Edit `home/rofi-launch/rasi.nix` to modify:
- Colors and transparency
- Window size and positioning
- Font and icon settings
- Border radius and effects

### Ulauncher Theme
The custom theme is automatically applied. To modify:
- Edit the CSS in `home/ulauncher/default.nix`
- Colors match your existing OneDark color scheme
- Uses JetBrains Mono Nerd Font for consistency

### Adding Custom Shortcuts (Ulauncher)
Edit the `shortcuts.json` section in `home/ulauncher/default.nix`:
```nix
"your-id-here" = {
  id = "your-id-here";
  name = "Your Shortcut";
  keyword = "keyword";
  cmd = "command %s";
  icon = "/path/to/icon.png";
  is_default_search = false;
  run_without_argument = false;
  added = 3;
};
```

## Rebuilding Configuration

After making changes, rebuild your NixOS configuration:
```bash
sudo nixos-rebuild switch --flake .
```

Or if using nh:
```bash
nh os switch
```

## Troubleshooting

### Ulauncher not starting
1. Check if the service is enabled:
   ```bash
   systemctl --user status ulauncher
   ```
2. Restart the service:
   ```bash
   systemctl --user restart ulauncher
   ```

### Theme not applied
1. For Rofi: Check if the theme file exists in `~/.config/rofi/themes/`
2. For Ulauncher: Check if the user theme directory was created in `~/.config/ulauncher/user-themes/`

### Keybinds not working
1. Check Hyprland configuration reload:
   ```bash
   hyprctl reload
   ```
2. Verify the launcher scripts are in PATH:
   ```bash
   which rofi-launcher ulauncher-launcher
   ```
