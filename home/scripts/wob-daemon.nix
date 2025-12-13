{ pkgs, ... }:

pkgs.writeShellScriptBin "wob-daemon" ''
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  WOB_SOCK="$XDG_RUNTIME_DIR/wob.sock"

  # Kill existing wob instances
  pkill wob 2>/dev/null

  # Remove old socket if exists
  rm -f "$WOB_SOCK"

  # Create named pipe
  mkfifo "$WOB_SOCK"

  # Start wob daemon
  tail -f "$WOB_SOCK" | ${pkgs.wob}/bin/wob &

  echo "wob daemon started on $WOB_SOCK"
''
