{ pkgs, ... }:

pkgs.writeShellScriptBin "battery-monitor" ''
  export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"

  NOTIFY_ID=8888
  CHARGING_SOUND="${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/power-plug.oga"
  DISCHARGING_SOUND="${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/power-unplug.oga"

  get_battery_state() {
    ${pkgs.upower}/bin/upower -e | grep -i "state" | head -1 | awk '{print $NF}'
  }

  get_battery_percentage() {
    ${pkgs.upower}/bin/upower -e | grep -i "percentage" | head -1 | awk '{print $NF}'
  }

  play_sound() {
    local sound_file="$1"
    if [ -f "$sound_file" ]; then
      ${pkgs.pipewire}/bin/paplay "$sound_file" &
    fi
  }

  send_notification() {
    local title="$1"
    local message="$2"

    ${pkgs.libnotify}/bin/notify-send \
      --replace-id=$NOTIFY_ID \
      -u normal \
      -t 2000 \
      --hint=int:transient:1 \
      "$title" "$message" || true
  }

  monitor_battery() {
    local prev_state=""
    local current_state=""

    while true; do
      current_state=$(get_battery_state)
      local percentage=$(get_battery_percentage)

      if [ "$prev_state" != "$current_state" ]; then
        case "$current_state" in
          "charging"|"fully-charged")
            play_sound "$CHARGING_SOUND"
            send_notification "⚡ Charging" "$percentage"
            ;;
          "discharging")
            play_sound "$DISCHARGING_SOUND"
            send_notification "🔋 Discharging" "$percentage"
            ;;
        esac
        prev_state="$current_state"
      fi

      sleep 2
    done
  }

  case "''${1:-}" in
    --daemon)
      monitor_battery
      ;;
    --status)
      echo "Battery State: $(get_battery_state)"
      echo "Battery Percentage: $(get_battery_percentage)"
      ;;
    --help|-h)
      cat << 'HELP'
Battery Monitor with Sound Notifications

Usage: battery-monitor [COMMAND]

Commands:
    --daemon        Start battery monitoring daemon
    --status        Show current battery status
    --help, -h      Show this help message

Examples:
    battery-monitor --daemon   # Start monitoring
    battery-monitor --status   # Show current battery

HELP
      ;;
    *)
      monitor_battery
      ;;
  esac
''
