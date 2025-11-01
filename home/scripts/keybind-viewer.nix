{ pkgs }:

pkgs.writeShellScriptBin "keybind-viewer" ''
  #!/usr/bin/env bash

  # Hyprland Keybinding Viewer with Rofi
  # Beautiful and comprehensive keybinding cheat sheet

  # Define keybindings with categories and colors
  KEYBINDS=$(cat << 'EOF'
<span color="#89b4fa" weight="bold" size="large">🚀 HYPRLAND KEYBINDINGS CHEAT SHEET</span>

<span color="#f38ba8" weight="bold" size="medium">📱 APPLICATION SHORTCUTS</span>
<span color="#a6e3a1">Super + Return</span>          <span color="#cdd6f4">Terminal (Ghostty)</span>
<span color="#a6e3a1">Super + T</span>              <span color="#cdd6f4">Terminal</span>
<span color="#a6e3a1">Super + B</span>              <span color="#cdd6f4">Browser (Zen)</span>
<span color="#a6e3a1">Super + F</span>              <span color="#cdd6f4">File Manager (Nautilus)</span>
<span color="#a6e3a1">Super + D</span>              <span color="#cdd6f4">App Launcher (Rofi)</span>
<span color="#a6e3a1">Super + Space</span>          <span color="#cdd6f4">App Runner (Anyrun)</span>
<span color="#a6e3a1">Super + E</span>              <span color="#cdd6f4">Emoji Picker</span>
<span color="#a6e3a1">Super + Ctrl + V</span>       <span color="#cdd6f4">Volume Control (Pavucontrol)</span>

<span color="#fab387" weight="bold" size="medium">🪟 WINDOW MANAGEMENT</span>
<span color="#a6e3a1">Super + Q</span>              <span color="#cdd6f4">Close Active Window</span>
<span color="#a6e3a1">Super + M</span>              <span color="#cdd6f4">Toggle Floating Mode</span>
<span color="#a6e3a1">Super + X</span>              <span color="#cdd6f4">Toggle Fullscreen</span>
<span color="#a6e3a1">Super + H/J/K/L</span>        <span color="#cdd6f4">Focus Window (Left/Down/Up/Right)</span>
<span color="#a6e3a1">Super + Shift + H/J/K/L</span> <span color="#cdd6f4">Move Window</span>
<span color="#a6e3a1">Super + Mouse1</span>         <span color="#cdd6f4">Move Window with Mouse</span>
<span color="#a6e3a1">Super + Mouse2</span>         <span color="#cdd6f4">Resize Window with Mouse</span>

<span color="#94e2d5" weight="bold" size="medium">🖥️ WORKSPACE CONTROLS</span>
<span color="#a6e3a1">Super + 1-9</span>           <span color="#cdd6f4">Switch to Workspace 1-9</span>
<span color="#a6e3a1">Super + 0</span>             <span color="#cdd6f4">Switch to Workspace 10</span>
<span color="#a6e3a1">Super + Shift + 1-9</span>   <span color="#cdd6f4">Move Window to Workspace</span>
<span color="#a6e3a1">Alt + Tab</span>             <span color="#cdd6f4">Next Workspace</span>
<span color="#a6e3a1">Alt + Shift + Tab</span>     <span color="#cdd6f4">Previous Workspace</span>

<span color="#cba6f7" weight="bold" size="medium">📸 SCREENSHOT & MEDIA</span>
<span color="#a6e3a1">Super + S</span>             <span color="#cdd6f4">Full Screenshot</span>
<span color="#a6e3a1">Super + Shift + S</span>     <span color="#cdd6f4">Area Screenshot (Select Region)</span>
<span color="#a6e3a1">Super + F5</span>            <span color="#cdd6f4">Screenshot (Alternative)</span>
<span color="#a6e3a1">Super + Shift + H</span>     <span color="#cdd6f4">Screenshot Output</span>

<span color="#f9e2af" weight="bold" size="medium">🎵 MEDIA & HARDWARE CONTROLS</span>
<span color="#a6e3a1">XF86AudioRaiseVolume</span>  <span color="#cdd6f4">Volume Up</span>
<span color="#a6e3a1">XF86AudioLowerVolume</span>  <span color="#cdd6f4">Volume Down</span>
<span color="#a6e3a1">XF86AudioMute</span>         <span color="#cdd6f4">Mute/Unmute Audio</span>
<span color="#a6e3a1">XF86MonBrightnessUp</span>   <span color="#cdd6f4">Increase Brightness</span>
<span color="#a6e3a1">XF86MonBrightnessDown</span> <span color="#cdd6f4">Decrease Brightness</span>

<span color="#f38ba8" weight="bold" size="medium">🔧 SYSTEM CONTROLS</span>
<span color="#a6e3a1">Super + L</span>             <span color="#cdd6f4">Lock Screen (Hyprlock)</span>
<span color="#a6e3a1">Super + P</span>             <span color="#cdd6f4">Power Menu (Wlogout)</span>
<span color="#a6e3a1">Super + Escape</span>        <span color="#cdd6f4">Exit Hyprland Session</span>
<span color="#a6e3a1">Super + W</span>             <span color="#cdd6f4">Wallpaper Changer (Waypaper)</span>
<span color="#a6e3a1">Super + Shift + W</span>     <span color="#cdd6f4">Toggle Dock (nwg-dock)</span>

<span color="#89dceb" weight="bold" size="medium">📋 UTILITY SHORTCUTS</span>
<span color="#a6e3a1">Super + Shift + V</span>     <span color="#cdd6f4">Clipboard History (Cliphist)</span>
<span color="#a6e3a1">Super + Alt + B</span>       <span color="#cdd6f4">Toggle Hyprpanel</span>
<span color="#a6e3a1">Super + ?</span>             <span color="#cdd6f4">Show This Keybinding Help</span>

<span color="#6c7086" weight="bold" style="italic" size="small">Press Enter on any item to copy the keybind • Press Escape to close</span>
EOF
)

  # Rofi configuration with Catppuccin-inspired theme
  ROFI_CONFIG="
  configuration {
    modes: \"drun,run,filebrowser,keys\";
    font: \"JetBrains Mono Nerd Font 11\";
    show-icons: true;
    icon-theme: \"Papirus-Dark\";
    display-drun: \"Applications\";
    display-run: \"Run\";
    display-filebrowser: \"Files\";
    display-keys: \"Keys\";
    drun-display-format: \"{name}\";
    disable-history: false;
    fullscreen: false;
    hide-scrollbar: true;
    sidebar-mode: false;
  }

  @theme \"default\"

  * {
    bg-col: rgba(30, 30, 46, 0.95);
    bg-col-light: rgba(49, 50, 68, 0.8);
    border-col: rgba(137, 180, 250, 0.8);
    selected-col: rgba(137, 180, 250, 0.2);
    blue: #89b4fa;
    fg-col: #cdd6f4;
    fg-col2: #6c7086;
    grey: #6c7086;
    pink: #f5c2e7;
    green: #a6e3a1;
    red: #f38ba8;
    yellow: #f9e2af;
    peach: #fab387;
    teal: #94e2d5;
    lavender: #b4befe;
  }

  element-text, element-icon, mode-switcher {
    background-color: inherit;
    text-color: inherit;
  }

  window {
    height: 75%;
    width: 65%;
    border: 2px;
    border-color: @border-col;
    border-radius: 12px;
    background-color: @bg-col;
    location: center;
    anchor: center;
  }

  mainbox {
    background-color: @bg-col;
    border-radius: 12px;
    children: [inputbar, listview];
    spacing: 10px;
    padding: 20px;
  }

  inputbar {
    children: [prompt, entry];
    background-color: @bg-col-light;
    border-radius: 8px;
    padding: 8px;
    border: 1px;
    border-color: @grey;
  }

  prompt {
    background-color: @blue;
    color: @bg-col;
    padding: 6px 12px;
    text-color: @bg-col;
    border-radius: 6px;
    margin: 0 10px 0 0;
    font: \"JetBrains Mono Nerd Font Bold 11\";
  }

  textbox-prompt-colon {
    expand: false;
    str: \":\";
  }

  entry {
    font: \"JetBrains Mono Nerd Font 11\";
    placeholder-color: @grey;
    placeholder: \"Search keybindings...\";
    background-color: transparent;
    color: @fg-col;
  }

  listview {
    border: 0px 0px 0px;
    padding: 6px 0px 0px;
    columns: 1;
    lines: 20;
    background-color: @bg-col;
    scrollbar: false;
  }

  element {
    padding: 8px 12px;
    background-color: @bg-col;
    text-color: @fg-col;
    border-radius: 6px;
    margin: 0 0 4px 0;
  }

  element-icon {
    size: 20px;
    margin: 0 8px 0 0;
  }

  element selected {
    background-color: @selected-col;
    border: 1px solid @blue;
    text-color: @blue;
  }

  mode-switcher {
    spacing: 0;
  }

  button {
    padding: 10px;
    background-color: @bg-col-light;
    text-color: @grey;
    vertical-align: 0.5;
    horizontal-align: 0.5;
  }

  button selected {
    background-color: @bg-col;
    text-color: @blue;
  }
  "

  # Create temporary config file
  CONFIG_FILE=$(mktemp)
  echo "$ROFI_CONFIG" > "$CONFIG_FILE"

  # Show keybindings in rofi with copy functionality
  SELECTION=$(echo "$KEYBINDS" | ${pkgs.rofi-wayland}/bin/rofi \
    -dmenu \
    -markup-rows \
    -i \
    -p "Keybindings" \
    -config "$CONFIG_FILE" \
    -theme-str 'window {width: 65%; height: 75%;}' \
    -theme-str 'listview {lines: 22;}' \
    -no-custom \
    -format 'f' \
    -selected-row 0)

  # Clean up temporary config
  rm -f "$CONFIG_FILE"

  # If user selected something, try to extract and copy the keybind
  if [[ -n "$SELECTION" ]]; then
    # Extract the keybind from the selected line (text between <span color="#a6e3a1"> tags)
    KEYBIND=$(echo "$SELECTION" | sed -n 's/.*<span color="#a6e3a1">\([^<]*\)<\/span>.*/\1/p')

    if [[ -n "$KEYBIND" ]]; then
      # Copy to clipboard
      echo -n "$KEYBIND" | ${pkgs.wl-clipboard}/bin/wl-copy

      # Show confirmation notification
      ${pkgs.libnotify}/bin/notify-send \
        --urgency=low \
        --expire-time=2000 \
        --icon="edit-copy" \
        "Keybind Copied" \
        "Copied '$KEYBIND' to clipboard"
    fi
  fi
''
