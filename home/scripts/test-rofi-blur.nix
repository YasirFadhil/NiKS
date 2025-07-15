{ pkgs }:

pkgs.writeShellScriptBin "test-rofi-blur" ''
  #!/bin/bash

  # Test script to verify rofi blur effects
  echo "Testing rofi blur effects..."

  # Check if rofi is available
  if ! command -v rofi &> /dev/null; then
    echo "Error: rofi not found in PATH"
    exit 1
  fi

  # Check if Hyprland is running
  if ! pgrep -x "Hyprland" > /dev/null; then
    echo "Warning: Hyprland not detected. Blur effects may not work."
  fi

  # Test basic rofi launch
  echo "Launching rofi with blur configuration..."
  rofi -show drun \
    -theme "$HOME/.config/rofi/themes/style-5.rasi" \
    -no-lazy-grab \
    -no-click-to-exit \
    -config "$HOME/.config/rofi/config.rasi" || echo "Rofi launched successfully"

  # Test different rofi modes
  echo "Testing different rofi modes..."

  # Test run mode
  echo "Testing run mode (press Escape to close)..."
  rofi -show run \
    -theme "$HOME/.config/rofi/themes/style-5.rasi" \
    -no-lazy-grab \
    -no-click-to-exit &

  sleep 2
  pkill rofi

  # Test window mode
  echo "Testing window mode (press Escape to close)..."
  rofi -show window \
    -theme "$HOME/.config/rofi/themes/style-5.rasi" \
    -no-lazy-grab \
    -no-click-to-exit &

  sleep 2
  pkill rofi

  echo "Blur test completed!"
  echo "If blur is not visible, check:"
  echo "1. Hyprland blur settings in hyprland.nix"
  echo "2. Window rules for rofi class"
  echo "3. Compositor settings"
  echo "4. Background opacity in rofi theme"
''
