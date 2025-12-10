{ pkgs, ... }:

pkgs.writeShellScriptBin "battery" ''
  battery_path="/org/freedesktop/UPower/devices/battery_BAT0"
  battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
  battery_status=$(cat /sys/class/power_supply/BAT0/status)

  # Ikon berdasarkan level baterai
  battery_icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
  icon_index=$((battery_percentage / 10))
  battery_icon=''${battery_icons[$icon_index]}

  # Ambil time remaining (kalau discharging)
  time_remaining=""
  if [ "$battery_status" = "Discharging" ]; then
    time=$(${pkgs.upower}/bin/upower -i "$battery_path" | grep "time to empty" | awk '{print $4 " " $5}')
    time_remaining="($time remaining)"
  fi

  # Output akhir
  if [ "$battery_status" = "Charging" ]; then
    if [ "$battery_percentage" -ge 100 ]; then
      echo "Charged"
    else
      echo "$battery_percentage% Charging "
    fi
  else
    echo "$battery_percentage% $battery_icon"
  fi
''
