{ pkgs, ... }:

pkgs.writeShellScriptBin "clipboard-manager" ''
  export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"

  case "$1" in
    show)
      # Show clipboard history with rofi
      ${pkgs.cliphist}/bin/cliphist list | ${pkgs.rofi}/bin/rofi -dmenu -p "Clipboard" -i | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy
      ;;
    clear)
      # Clear clipboard history
      ${pkgs.cliphist}/bin/cliphist wipe
      ${pkgs.libnotify}/bin/notify-send "Clipboard" "History cleared" -i edit-clear
      ;;
    store-text)
      # Store text clipboard (used in startup)
      ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store
      ;;
    store-image)
      # Store image clipboard (used in startup)
      ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store
      ;;
    status)
      # Show current clipboard content
      current=$(${pkgs.wl-clipboard}/bin/wl-paste -n 2>/dev/null | head -c 50)
      if [ -n "$current" ]; then
        echo "Current clipboard: $current..."
      else
        echo "Clipboard is empty"
      fi
      ;;
    *)
      echo "Usage: $0 {show|clear|store-text|store-image|status}"
      echo "  show        - Show clipboard history with rofi"
      echo "  clear       - Clear clipboard history"
      echo "  store-text  - Start text clipboard monitoring"
      echo "  store-image - Start image clipboard monitoring"
      echo "  status      - Show current clipboard content"
      ;;
  esac
''
