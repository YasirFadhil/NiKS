{ config, pkgs, lib, ... }:

{
  home.file.".config/scripts/swaync-shot.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Screenshot script for swaync

      # Create screenshots directory if it doesn't exist
      SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
      mkdir -p "$SCREENSHOT_DIR"

      # Generate filename with timestamp
      FILENAME="screenshot_$(date +%Y%m%d_%H%M%S).png"
      FILEPATH="$SCREENSHOT_DIR/$FILENAME"

      # Close swaync panel
      swaync-client --close-panel

      # Wait a moment for panel to close
      sleep 0.3

      # Take screenshot using grim and slurp for area selection
      if grim -g "$(slurp)" "$FILEPATH"; then
          # Copy to clipboard
          wl-copy < "$FILEPATH"

          # Send success notification
          notify-send "📷 Screenshot Captured!" \
              "Saved to: $FILENAME\nCopied to clipboard" \
              --icon="$FILEPATH" \
              --app-name="Screenshot"
      else
          # Send error notification if screenshot failed
          notify-send "❌ Screenshot Failed!" \
              "Unable to capture screenshot" \
              --urgency=critical \
              --app-name="Screenshot"
      fi
    '';
    executable = true;
  };
}
