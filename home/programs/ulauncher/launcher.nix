{ pkgs }:

pkgs.writeShellScriptBin "ulauncher-launcher" ''
  # Check if ulauncher is already running
  if pgrep -x "ulauncher" > /dev/null; then
    # If running, toggle the window
    ulauncher-toggle
  else
    # If not running, start ulauncher and show window
    ulauncher --no-window-shadow &
    sleep 0.5
    ulauncher-toggle
  fi
''
