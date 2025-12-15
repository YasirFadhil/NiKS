{ pkgs, ... }:

pkgs.writeShellScriptBin "audio-sink" ''
  export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"

  NOTIFY_ID=9999

  # Sink names to toggle between
  SINK_1="Celeron/Pentium Silver Processor High Definition Audio Pro"
  SINK_2="Celeron/Pentium Silver Processor High Definition Audio Pro 1"

  get_current_sink() {
    ${pkgs.wireplumber}/bin/wpctl status audio | sed -n '/├─ Sinks:/,/├─ Sources:/p' | grep '\*' | head -1 | grep -o '[0-9]\+' | head -1
  }

  get_sink_name() {
    local sink_id="$1"
    ${pkgs.wireplumber}/bin/wpctl status audio | sed -n '/├─ Sinks:/,/├─ Sources:/p' | grep " $sink_id\." | sed 's/.*\. //' | sed 's/ \[.*//'
  }

  get_sink_id_by_name() {
    local sink_name="$1"
    ${pkgs.wireplumber}/bin/wpctl status audio | sed -n '/├─ Sinks:/,/├─ Sources:/p' | grep "$sink_name" | head -1 | grep -o '[0-9]\+' | head -1
  }

  get_sink_icon() {
    local sink_name="$1"
    if [ "$sink_name" = "$SINK_2" ]; then
      echo "󰋋"
    else
      echo "󰓃"
    fi
  }

  send_notification() {
    local sink_id="$1"
    local sink_name="$2"
    local icon=$(get_sink_icon "$sink_name")

    ${pkgs.libnotify}/bin/notify-send \
      --replace-id=$NOTIFY_ID \
      -u normal \
      -t 2000 \
      --hint=int:transient:1 \
      "Audio Sink" "$icon $sink_name" || true
  }

  send_error_notification() {
    ${pkgs.libnotify}/bin/notify-send \
      --replace-id=$NOTIFY_ID \
      -u critical \
      -t 2000 \
      --hint=int:transient:1 \
      "Audio Sink Error" "Failed to switch sink" || true
  }

  set_sink() {
    local sink_name="$1"
    local sink_id=$(get_sink_id_by_name "$sink_name")

    if [ -z "$sink_id" ]; then
      echo "✗ Sink '$sink_name' not found"
      send_error_notification
      return 1
    fi

    if ${pkgs.wireplumber}/bin/wpctl set-default "$sink_id" 2>/dev/null; then
      echo "✓ Switched to: $sink_name"
      send_notification "$sink_id" "$sink_name"
    else
      echo "✗ Failed to set sink"
      send_error_notification
      return 1
    fi
  }

  toggle_sink() {
    local current_id=$(get_current_sink)
    local current_name=$(get_sink_name "$current_id")

    if [ "$current_name" = "$SINK_2" ]; then
      set_sink "$SINK_1"
    else
      set_sink "$SINK_2"
    fi
  }

  show_status() {
    local current=$(get_current_sink)
    local current_name=$(get_sink_name "$current")
    local icon=$(get_sink_icon "$current_name")

    echo "Current sink: [$current] $current_name"
    echo ""
    echo "Available sinks:"
    ${pkgs.wireplumber}/bin/wpctl status audio | sed -n '/├─ Sinks:/,/├─ Sources:/p' | grep -E "Pro|Pro 1"

    ${pkgs.libnotify}/bin/notify-send \
      --replace-id=$NOTIFY_ID \
      -u normal \
      -t 2500 \
      --hint=int:transient:1 \
      "Audio Sink" "$icon $current_name" || true
  }

  case "''${1:-}" in
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
    --toggle, -t        Toggle between sinks
    --status, -s        Show current sink status
    --help, -h          Show this help message

Examples:
    audio-sink --toggle  # Toggle between Pro and Pro 1
    audio-sink --status  # Show current sink

HELP
      ;;
    *)
      toggle_sink
      ;;
  esac
''
