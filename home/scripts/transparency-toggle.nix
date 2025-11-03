{ pkgs, ... }:

let
  transparency-toggle = pkgs.writeShellScriptBin "transparency-toggle" ''
    #!/usr/bin/env bash

    # Transparency Toggle Script for Hyprland
    # This script allows you to toggle between different transparency levels

    CONFIG_FILE="$HOME/.config/hypr/transparency-state"

    # Create config directory if it doesn't exist
    mkdir -p "$(dirname "$CONFIG_FILE")"

    # Read current state (default to "normal" if file doesn't exist)
    if [[ -f "$CONFIG_FILE" ]]; then
        CURRENT_STATE=$(cat "$CONFIG_FILE")
    else
        CURRENT_STATE="normal"
    fi

    # Define transparency states
    case "$CURRENT_STATE" in
        "normal")
            # Switch to high transparency
            hyprctl keyword decoration:active_opacity 0.75
            hyprctl keyword decoration:inactive_opacity 0.60
            hyprctl keyword decoration:blur:size 25
            hyprctl keyword decoration:blur:passes 5
            echo "high" > "$CONFIG_FILE"
            notify-send -u low -t 2000 "Transparency" "High transparency mode" -i dialog-information
            ;;
        "high")
            # Switch to opaque
            hyprctl keyword decoration:active_opacity 1.0
            hyprctl keyword decoration:inactive_opacity 1.0
            hyprctl keyword decoration:blur:enabled false
            echo "opaque" > "$CONFIG_FILE"
            notify-send -u low -t 2000 "Transparency" "Opaque mode (no transparency)" -i dialog-information
            ;;
        "opaque")
            # Switch back to normal
            hyprctl keyword decoration:active_opacity 0.85
            hyprctl keyword decoration:inactive_opacity 0.75
            hyprctl keyword decoration:blur:enabled true
            hyprctl keyword decoration:blur:size 20
            hyprctl keyword decoration:blur:passes 4
            echo "normal" > "$CONFIG_FILE"
            notify-send -u low -t 2000 "Transparency" "Normal transparency mode" -i dialog-information
            ;;
        *)
            # Reset to normal if state is unknown
            hyprctl keyword decoration:active_opacity 0.85
            hyprctl keyword decoration:inactive_opacity 0.75
            hyprctl keyword decoration:blur:enabled true
            hyprctl keyword decoration:blur:size 20
            hyprctl keyword decoration:blur:passes 4
            echo "normal" > "$CONFIG_FILE"
            notify-send -u low -t 2000 "Transparency" "Reset to normal transparency" -i dialog-warning
            ;;
    esac
  '';

  transparency-adjust = pkgs.writeShellScriptBin "transparency-adjust" ''
    #!/usr/bin/env bash

    # Transparency Adjustment Script
    # Usage: transparency-adjust [increase|decrease|set VALUE]

    # Get current opacity values
    CURRENT_ACTIVE=$(hyprctl getoption decoration:active_opacity | grep "float" | awk '{print $2}')
    CURRENT_INACTIVE=$(hyprctl getoption decoration:inactive_opacity | grep "float" | awk '{print $2}')

    case "$1" in
        "increase")
            NEW_ACTIVE=$(echo "$CURRENT_ACTIVE + 0.05" | bc -l)
            NEW_INACTIVE=$(echo "$CURRENT_INACTIVE + 0.05" | bc -l)
            # Cap at 1.0
            if (( $(echo "$NEW_ACTIVE > 1.0" | bc -l) )); then
                NEW_ACTIVE=1.0
            fi
            if (( $(echo "$NEW_INACTIVE > 1.0" | bc -l) )); then
                NEW_INACTIVE=1.0
            fi
            ;;
        "decrease")
            NEW_ACTIVE=$(echo "$CURRENT_ACTIVE - 0.05" | bc -l)
            NEW_INACTIVE=$(echo "$CURRENT_INACTIVE - 0.05" | bc -l)
            # Cap at 0.3 (minimum usable transparency)
            if (( $(echo "$NEW_ACTIVE < 0.3" | bc -l) )); then
                NEW_ACTIVE=0.3
            fi
            if (( $(echo "$NEW_INACTIVE < 0.3" | bc -l) )); then
                NEW_INACTIVE=0.3
            fi
            ;;
        "set")
            if [[ -z "$2" ]] || ! [[ "$2" =~ ^[0-9]*\.?[0-9]+$ ]]; then
                echo "Usage: transparency-adjust set <value>"
                echo "Value should be between 0.3 and 1.0"
                exit 1
            fi
            NEW_ACTIVE="$2"
            NEW_INACTIVE=$(echo "$2 - 0.1" | bc -l)
            # Ensure inactive is not less than 0.3
            if (( $(echo "$NEW_INACTIVE < 0.3" | bc -l) )); then
                NEW_INACTIVE=0.3
            fi
            ;;
        *)
            echo "Usage: transparency-adjust [increase|decrease|set VALUE]"
            echo "Current active opacity: $CURRENT_ACTIVE"
            echo "Current inactive opacity: $CURRENT_INACTIVE"
            exit 1
            ;;
    esac

    # Apply new values
    hyprctl keyword decoration:active_opacity "$NEW_ACTIVE"
    hyprctl keyword decoration:inactive_opacity "$NEW_INACTIVE"

    # Show notification
    PERCENT_ACTIVE=$(echo "scale=0; $NEW_ACTIVE * 100" | bc)
    notify-send -u low -t 2000 "Transparency" "Opacity: $PERCENT_ACTIVE%" -i dialog-information
  '';

  transparency-presets = pkgs.writeShellScriptBin "transparency-presets" ''
    #!/usr/bin/env bash

    # Transparency Presets Script
    # Provides quick access to different transparency configurations

    case "$1" in
        "gaming")
            # Opaque for gaming performance
            hyprctl keyword decoration:active_opacity 1.0
            hyprctl keyword decoration:inactive_opacity 1.0
            hyprctl keyword decoration:blur:enabled false
            notify-send -u low -t 2000 "Transparency" "Gaming mode: No transparency" -i applications-games
            ;;
        "work")
            # Moderate transparency for productivity
            hyprctl keyword decoration:active_opacity 0.95
            hyprctl keyword decoration:inactive_opacity 0.85
            hyprctl keyword decoration:blur:enabled true
            hyprctl keyword decoration:blur:size 15
            hyprctl keyword decoration:blur:passes 3
            notify-send -u low -t 2000 "Transparency" "Work mode: Subtle transparency" -i applications-office
            ;;
        "aesthetic")
            # High transparency for visual appeal
            hyprctl keyword decoration:active_opacity 0.75
            hyprctl keyword decoration:inactive_opacity 0.60
            hyprctl keyword decoration:blur:enabled true
            hyprctl keyword decoration:blur:size 30
            hyprctl keyword decoration:blur:passes 6
            hyprctl keyword decoration:blur:vibrancy 0.4
            notify-send -u low -t 2000 "Transparency" "Aesthetic mode: High transparency" -i preferences-desktop-theme
            ;;
        "default")
            # Reset to default values
            hyprctl keyword decoration:active_opacity 0.85
            hyprctl keyword decoration:inactive_opacity 0.75
            hyprctl keyword decoration:blur:enabled true
            hyprctl keyword decoration:blur:size 20
            hyprctl keyword decoration:blur:passes 4
            hyprctl keyword decoration:blur:vibrancy 0.35
            notify-send -u low -t 2000 "Transparency" "Default transparency restored" -i dialog-information
            ;;
        *)
            echo "Usage: transparency-presets [gaming|work|aesthetic|default]"
            echo ""
            echo "Presets:"
            echo "  gaming    - No transparency (best performance)"
            echo "  work      - Subtle transparency (productivity focused)"
            echo "  aesthetic - High transparency (maximum visual appeal)"
            echo "  default   - Balanced transparency settings"
            exit 1
            ;;
    esac
  '';

in
{
  home.packages = [
    transparency-toggle
    transparency-adjust
    transparency-presets
    pkgs.bc  # Required for floating point calculations
  ];
}
