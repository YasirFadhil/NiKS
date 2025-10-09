{ pkgs }:

pkgs.writeShellScriptBin "launcher-switcher" ''
  #!/usr/bin/env bash

  # Colors for output
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  BLUE='\033[0;34m'
  YELLOW='\033[1;33m'
  NC='\033[0m' # No Color

  # Configuration file path
  BINDS_FILE="$HOME/.config/nixos/home/hypr/binds.nix"

  # Function to show current launcher
  show_current() {
    echo -e "${BLUE}Current launcher configuration:${NC}"
    if grep -q '^[[:space:]]*"SUPER, D, exec, rofi-launcher"' "$BINDS_FILE"; then
      echo -e "${GREEN}✓ Rofi${NC} (SUPER + D)"
    elif grep -q '^[[:space:]]*"SUPER, D, exec, ulauncher-launcher"' "$BINDS_FILE"; then
      echo -e "${GREEN}✓ Ulauncher${NC} (SUPER + D)"
    elif grep -q '^[[:space:]]*"SUPER, D, exec, anyrun"' "$BINDS_FILE"; then
      echo -e "${GREEN}✓ Anyrun${NC} (SUPER + D)"
    else
      echo -e "${RED}✗ No launcher configured${NC}"
    fi
    echo ""
  }

  # Function to switch to rofi
  switch_to_rofi() {
    sed -i 's/^[[:space:]]*"SUPER, D, exec, ulauncher-launcher"/      # "SUPER, D, exec, ulauncher-launcher"/' "$BINDS_FILE"
    sed -i 's/^[[:space:]]*"SUPER, D, exec, anyrun"/      # "SUPER, D, exec, anyrun"/' "$BINDS_FILE"
    sed -i 's/^[[:space:]]*#[[:space:]]*"SUPER, D, exec, rofi-launcher"/      "SUPER, D, exec, rofi-launcher"/' "$BINDS_FILE"
    echo -e "${GREEN}✓ Switched to Rofi${NC}"
  }

  # Function to switch to ulauncher
  switch_to_ulauncher() {
    sed -i 's/^[[:space:]]*"SUPER, D, exec, rofi-launcher"/      # "SUPER, D, exec, rofi-launcher"/' "$BINDS_FILE"
    sed -i 's/^[[:space:]]*"SUPER, D, exec, anyrun"/      # "SUPER, D, exec, anyrun"/' "$BINDS_FILE"
    sed -i 's/^[[:space:]]*#[[:space:]]*"SUPER, D, exec, ulauncher-launcher"/      "SUPER, D, exec, ulauncher-launcher"/' "$BINDS_FILE"
    echo -e "${GREEN}✓ Switched to Ulauncher${NC}"
  }

  # Function to switch to anyrun
  switch_to_anyrun() {
    sed -i 's/^[[:space:]]*"SUPER, D, exec, rofi-launcher"/      # "SUPER, D, exec, rofi-launcher"/' "$BINDS_FILE"
    sed -i 's/^[[:space:]]*"SUPER, D, exec, ulauncher-launcher"/      # "SUPER, D, exec, ulauncher-launcher"/' "$BINDS_FILE"
    sed -i 's/^[[:space:]]*#[[:space:]]*"SUPER, D, exec, anyrun"/      "SUPER, D, exec, anyrun"/' "$BINDS_FILE"
    echo -e "${GREEN}✓ Switched to Anyrun${NC}"
  }

  # Function to reload hyprland config
  reload_hyprland() {
    echo -e "${YELLOW}Reloading Hyprland configuration...${NC}"
    if command -v hyprctl &> /dev/null; then
      hyprctl reload
      echo -e "${GREEN}✓ Hyprland configuration reloaded${NC}"
    else
      echo -e "${RED}✗ hyprctl not found. Please reload Hyprland manually.${NC}"
    fi
  }

  # Main menu
  show_menu() {
    echo -e "${BLUE}=== App Launcher Switcher ===${NC}"
    echo ""
    show_current
    echo "Available options:"
    echo "1) Switch to Rofi"
    echo "2) Switch to Ulauncher"
    echo "3) Switch to Anyrun"
    echo "4) Show current configuration"
    echo "5) Reload Hyprland config"
    echo "q) Quit"
    echo ""
    echo -n "Select an option: "
  }

  # Check if binds file exists
  if [ ! -f "$BINDS_FILE" ]; then
    echo -e "${RED}Error: binds.nix not found at $BINDS_FILE${NC}"
    echo "Please make sure you're running this from the correct directory."
    exit 1
  fi

  # Interactive mode if no arguments
  if [ $# -eq 0 ]; then
    while true; do
      show_menu
      read -r choice
      echo ""

      case $choice in
        1)
          switch_to_rofi
          reload_hyprland
          ;;
        2)
          switch_to_ulauncher
          reload_hyprland
          ;;
        3)
          switch_to_anyrun
          reload_hyprland
          ;;
        4)
          show_current
          ;;
        5)
          reload_hyprland
          ;;
        q|Q)
          echo -e "${BLUE}Goodbye!${NC}"
          exit 0
          ;;
        *)
          echo -e "${RED}Invalid option. Please try again.${NC}"
          ;;
      esac
      echo ""
      echo "Press Enter to continue..."
      read -r
      clear
    done
  fi

  # Command line mode
  case $1 in
    rofi|r)
      switch_to_rofi
      reload_hyprland
      ;;
    ulauncher|u)
      switch_to_ulauncher
      reload_hyprland
      ;;
    anyrun|a)
      switch_to_anyrun
      reload_hyprland
      ;;
    status|s)
      show_current
      ;;
    reload)
      reload_hyprland
      ;;
    help|h)
      echo "Usage: launcher-switcher [option]"
      echo ""
      echo "Options:"
      echo "  rofi, r       Switch to Rofi launcher"
      echo "  ulauncher, u  Switch to Ulauncher"
      echo "  anyrun, a     Switch to Anyrun"
      echo "  status, s     Show current launcher"
      echo "  reload        Reload Hyprland config"
      echo "  help, h       Show this help message"
      echo ""
      echo "Run without arguments for interactive mode."
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      echo "Use 'launcher-switcher help' for usage information."
      exit 1
      ;;
  esac
''
