{ pkgs, ... }:

pkgs.writeShellScriptBin "brightness-control" ''
  export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"

  NOTIFY_ID=7777

  get_brightness() {
    ${pkgs.brightnessctl}/bin/brightnessctl -m | awk -F',' '{print $4}' | tr -d '%'
  }

  get_brightness_bar() {
    local brightness=$(get_brightness)
    local filled=$((brightness / 10))
    local empty=$((10 - filled))

    printf "["
    for i in $(seq 1 $filled); do printf "█"; done
    for i in $(seq 1 $empty); do printf "░"; done
    printf "]"
  }

  get_brightness_icon() {
    local brightness=$(get_brightness)

    if [ "$brightness" -eq 0 ]; then
      echo "🌑"
    elif [ "$brightness" -lt 20 ]; then
      echo "🔅"
    elif [ "$brightness" -lt 50 ]; then
      echo "🔆"
    else
      echo "☀️"
    fi
  }

  send_notification() {
    local brightness=$(get_brightness)
    local icon=$(get_brightness_icon)
    local bar=$(get_brightness_bar)

    ${pkgs.libnotify}/bin/notify-send \
      --replace-id=$NOTIFY_ID \
      -u normal \
      -t 1500 \
      --hint=transient:true \
      "Brightness" "$icon $bar $brightness%" || true
  }

  case "$1" in
    up|+)
      ${pkgs.brightnessctl}/bin/brightnessctl set 5%+
      send_notification
      echo "Brightness: $(get_brightness)%"
      ;;
    down|-)
      ${pkgs.brightnessctl}/bin/brightnessctl set 5%-
      send_notification
      echo "Brightness: $(get_brightness)%"
      ;;
    max)
      ${pkgs.brightnessctl}/bin/brightnessctl set 100%
      send_notification
      echo "Brightness: $(get_brightness)%"
      ;;
    min)
      ${pkgs.brightnessctl}/bin/brightnessctl set 1%
      send_notification
      echo "Brightness: $(get_brightness)%"
      ;;
    status)
      send_notification
      echo "Brightness: $(get_brightness)%"
      ;;
    *)
      echo "Usage: $0 {up|down|max|min|status|+|-}"
      ;;
  esac
''
