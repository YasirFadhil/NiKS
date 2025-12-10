{ pkgs, ... }:

pkgs.writeShellScriptBin "volume-control" ''
  export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  SINK=$(${pkgs.pulseaudio}/bin/pactl info | grep 'Default Sink' | awk '{print $3}')
  get_volume() {
    ${pkgs.pulseaudio}/bin/pactl get-sink-volume "$SINK" | grep -o '[0-9]\+%' | head -1
  }

  get_mute() {
    ${pkgs.pulseaudio}/bin/pactl get-sink-mute "$SINK" | awk '{print $2}'
  }
  play_feedback_sound() {
    ${pkgs.libcanberra}/bin/canberra-gtk-play -i audio-volume-change
  }

  case "$1" in
    up)
      ${pkgs.pulseaudio}/bin/pactl set-sink-volume "$SINK" +5%
      play_feedback_sound
      echo "Volume: $(get_volume)"
      ;;
    down)
      ${pkgs.pulseaudio}/bin/pactl set-sink-volume "$SINK" -5%
      play_feedback_sound
      echo "Volume: $(get_volume)"
      ;;
    mute)
      ${pkgs.pulseaudio}/bin/pactl set-sink-mute "$SINK" toggle
      if [ "$(get_mute)" = "yes" ]; then
        ${pkgs.libcanberra}/bin/canberra-gtk-play -i audio-volume-muted -d "volume-feedback" &>/dev/null &
        echo "Muted"
      else
        play_feedback_sound
        echo "Unmuted - Volume: $(get_volume)"
      fi
      ;;
    status)
      if [ "$(get_mute)" = "yes" ]; then
        echo "Muted"
      else
        echo "Volume: $(get_volume)"
      fi
      ;;
    *)
      echo "Usage: $0 {up|down|mute|status}"
      ;;
  esac
''
