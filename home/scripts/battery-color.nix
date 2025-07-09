{ pkgs, ... }:

pkgs.writeShellScriptBin "battery-color" ''
  battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

  # Return color based on battery percentage for hyprlock
  if [ "$battery_percentage" -le 20 ]; then
    echo "rgba(255,99,71,1)"  # Red for critical
  elif [ "$battery_percentage" -le 30 ]; then
    echo "rgba(255,193,7,1)"  # Yellow for low
  else
    echo "rgba(40,167,69,1)"  # Green for normal
  fi
''
