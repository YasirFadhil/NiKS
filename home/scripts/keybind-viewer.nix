{ pkgs }:

pkgs.writeShellScriptBin "keybind-viewer" ''
  #!/usr/bin/env bash

  # Hyprland Keybinding Viewer with Rofi
  # Simple and working keybinding cheat sheet

  # Define keybindings with categories and colors
  KEYBINDS=$(cat << 'EOF'
<span color="#89b4fa" weight="bold" size="large">🚀 HYPRLAND KEYBINDINGS CHEAT SHEET</span>

<span color="#f38ba8" weight="bold" size="medium">📱 APPLICATION SHORTCUTS</span>
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
<span color="#a6e3a1">Super + / or ?</span>        <span color="#cdd6f4">Show This Keybinding Help</span>

<span color="#6c7086" weight="bold" style="italic" size="small">Press Enter on any item to copy the keybind • Press Escape to close</span>
EOF
)

  # Show keybindings in rofi with simple styling
  SELECTION=$(echo "$KEYBINDS" | ${pkgs.rofi}/bin/rofi \
    -dmenu \
    -markup-rows \
    -i \
    -p " Keybindings" \
    -theme-str 'window {width: 70%; height: 80%;}' \
    -theme-str 'listview {lines: 25; scrollbar: false;}' \
    -theme-str 'element-text {font: "JetBrains Mono Nerd Font 11";}' \
    -theme-str 'inputbar {children: [prompt,entry]; margin: 0 0 10px 0;}' \
    -theme-str 'prompt {background-color: @blue; text-color: @background; padding: 6px 12px; border-radius: 6px; margin: 0 10px 0 0;}' \
    -theme-str 'entry {placeholder: "Search keybindings...";}' \
    -theme-str 'element {padding: 8px; border-radius: 4px;}' \
    -theme-str 'element selected {background-color: @selected-normal-background; text-color: @selected-normal-foreground;}' \
    -no-custom \
    -format 'f' \
    -selected-row 0)

  # If user selected something, try to extract and copy the keybind
  if [[ -n "$SELECTION" ]]; then
    # Extract the keybind from the selected line (text between <span color="#[^"]*"> tags)
    KEYBIND=$(echo "$SELECTION" | sed -n 's/.*<span color="#[^"]*">\([^<]*\)<\/span>.*/\1/p')

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
