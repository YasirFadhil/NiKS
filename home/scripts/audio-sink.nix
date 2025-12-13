{ pkgs, ... }:

pkgs.writeShellScriptBin "audio-sink" ''
  export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"

  # Colors for output
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  BLUE='\033[0;34m'
  NC='\033[0m'

  get_current_sink() {
    ${pkgs.wireplumber}/bin/wpctl status audio | sed -n '/├─ Sinks:/,/├─ Sources:/p' | grep '\*' | head -1 | awk '{print $3}' | tr -d '.'
  }

  get_sink_name() {
    local sink_id="$1"
    ${pkgs.wireplumber}/bin/wpctl status audio | sed -n '/├─ Sinks:/,/├─ Sources:/p' | grep "$sink_id\." | sed "s/.*$sink_id\.\s*//" | sed 's/\s*\[.*//'
  }

  set_sink() {
    local sink_id="$1"
    if ${pkgs.wireplumber}/bin/wpctl set-default "$sink_id" 2>/dev/null; then
      local sink_name=$(get_sink_name "$sink_id")
      echo -e "''${GREEN}✓ Switched to: $sink_name''${NC}"
    else
      echo -e "''${RED}✗ Failed to set sink''${NC}"
      return 1
    fi
  }

  toggle_sink() {
    local current=$(get_current_sink)

    if [ "$current" = "59" ]; then
      set_sink 58
    else
      set_sink 59
    fi
  }

  show_status() {
    local current=$(get_current_sink)

    echo -e "''${BLUE}Current sink:''${NC} [$current]"
    echo ""
    echo -e "''${BLUE}Available sinks:''${NC}"
    ${pkgs.wireplumber}/bin/wpctl status audio | sed -n '/├─ Sinks:/,/├─ Sources:/p' | grep -E '(58|59)\.'
  }

  case "''${1:-}" in
    58)
      set_sink 58
      ;;
    59)
      set_sink 59
      ;;
    --toggle|-t)
      toggle_sink
      ;;
    --status|-s)
      show_status
      ;;
    --help|-h)
      cat << 'HELP'
PipeWire Audio Sink Switcher

Usage: audio-sink [COMMAND]

Commands:
    58                  Switch to sink 58
    59                  Switch to sink 59
    --toggle, -t        Toggle between sinks 58 and 59
    --status, -s        Show current sink status
    --help, -h          Show this help message

Examples:
    audio-sink 58        # Switch to sink 58
    audio-sink --toggle  # Toggle between 58 and 59
    audio-sink --status  # Show current sink

HELP
      ;;
    *)
      toggle_sink
      ;;
  esac
''
