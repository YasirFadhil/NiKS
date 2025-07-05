# ~/nixos-config/pkgs/nowplay/default.nix
{ pkgs, writeScriptBin }:

writeScriptBin "nowplay" ''
  #!/bin/bash

  status=$(${pkgs.playerctl}/bin/playerctl status 2>/dev/null)
  [[ "$status" != "Playing" && "$status" != "Paused" ]] && exit 0

  player=$(${pkgs.playerctl}/bin/playerctl -l 2>/dev/null | head -n 1)
  title=$(${pkgs.playerctl}/bin/playerctl metadata title 2>/dev/null)
  artist=$(${pkgs.playerctl}/bin/playerctl metadata artist 2>/dev/null)

  # Deteksi ikon berdasarkan nama player
  case "$player" in
  *spotify*) icon=" Spotify: " ;;
  *firefox* | *brave* | *chromium* | *chrome*) icon=" YouTube: " ;;
  *vlc*) icon="嗢 VLC: " ;;
  *mpv*) icon=" MPV: " ;;
  *kdeconnect*) icon=" KDE Connect: " ;;
  *) icon=" Playing: " ;;
  esac

  if [[ -n "$artist" ]]; then
    echo "$icon $artist - $title"
  else
    echo "$icon $title"
  fi
''
