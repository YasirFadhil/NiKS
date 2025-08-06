{ pkgs, ... }:

pkgs.writeShellScriptBin "nowplay" ''
  status=$(playerctl status 2>/dev/null)
  [[ "$status" != "Playing" && "$status" != "Paused" ]] && exit 0

  player=$(playerctl -l 2>/dev/null | head -n 1)
  title=$(playerctl metadata title 2>/dev/null)
  artist=$(playerctl metadata artist 2>/dev/null)

  case "$player" in
    *spotify*) icon="  Spotify: " ;;
    #*firefox* | *brave* | *chromium* | *chrome*) icon="  YouTube: " ;;
    *firefox*) icon="  Zen Browser: " ;;
    *google-chrome-stable* | *chromium*) icon="  Chrome: " ;;
    *kdeconnect*) icon="📱  KDE Connect: " ;;
  esac

  max_length=30
  if [ "$(echo -n "$title" | wc -c)" -gt "$max_length" ]; then
    title="$(echo -n "$title" | cut -c1-30)..."
    artist="$(echo -n "$artist" | cut -c1-30)..."
  fi

  if [[ -n "$artist" ]]; then
    echo "$icon $artist - $title"
  else
    echo "$icon $title"
  fi
''
