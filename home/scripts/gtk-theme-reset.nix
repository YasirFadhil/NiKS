{ pkgs, ... }:

pkgs.writeShellScriptBin "gtk-theme-reset" ''
  #!/usr/bin/env bash

  # GTK Theme Reset and Reload Script
  # This script helps fix GTK theming issues by resetting and reapplying themes

  set -e

  echo "🎨 GTK Theme Reset and Reload Script"
  echo "===================================="

  # Colors for output
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  BLUE='\033[0;34m'
  NC='\033[0m' # No Color

  # Function to print colored output
  print_status() {
      echo -e "''${BLUE}[INFO]''${NC} $1"
  }

  print_success() {
      echo -e "''${GREEN}[SUCCESS]''${NC} $1"
  }

  print_warning() {
      echo -e "''${YELLOW}[WARNING]''${NC} $1"
  }

  print_error() {
      echo -e "''${RED}[ERROR]''${NC} $1"
  }

  # Check if we're in a Wayland session
  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
      print_status "Running in Wayland session"
      WAYLAND_SESSION=true
  else
      print_status "Running in X11 session"
      WAYLAND_SESSION=false
  fi

  # Function to check if a command exists
  command_exists() {
      command -v "$1" >/dev/null 2>&1
  }

  # Function to restart GTK applications gracefully
  restart_gtk_apps() {
      print_status "Restarting GTK applications..."

      # List of common GTK applications to restart
      local gtk_apps=("nautilus" "gnome-settings-daemon" "gnome-shell")

      for app in "''${gtk_apps[@]}"; do
          if pgrep -x "$app" > /dev/null; then
              print_status "Restarting $app..."
              pkill -x "$app" || true
              sleep 1
              if command_exists "$app"; then
                  nohup "$app" > /dev/null 2>&1 &
              fi
          fi
      done
  }

  # Function to clear GTK caches
  clear_gtk_caches() {
      print_status "Clearing GTK caches..."

      # Remove GTK icon cache
      if [ -d "$HOME/.cache/gtk-3.0" ]; then
          rm -rf "$HOME/.cache/gtk-3.0"
          print_success "Cleared GTK 3.0 cache"
      fi

      if [ -d "$HOME/.cache/gtk-4.0" ]; then
          rm -rf "$HOME/.cache/gtk-4.0"
          print_success "Cleared GTK 4.0 cache"
      fi

      # Clear icon theme cache
      if [ -d "$HOME/.cache/icon-theme.cache" ]; then
          rm -rf "$HOME/.cache/icon-theme.cache"
          print_success "Cleared icon theme cache"
      fi

      # Clear fontconfig cache
      if command_exists fc-cache; then
          fc-cache -fv > /dev/null 2>&1
          print_success "Refreshed fontconfig cache"
      fi
  }

  # Function to update icon cache
  update_icon_cache() {
      print_status "Updating icon caches..."

      local icon_dirs=(
          "/usr/share/icons"
          "$HOME/.local/share/icons"
          "$HOME/.nix-profile/share/icons"
          "/run/current-system/sw/share/icons"
      )

      for icon_dir in "''${icon_dirs[@]}"; do
          if [ -d "$icon_dir" ]; then
              for theme_dir in "$icon_dir"/*; do
                  if [ -d "$theme_dir" ] && [ -f "$theme_dir/index.theme" ]; then
                      theme_name=$(basename "$theme_dir")
                      if command_exists gtk-update-icon-cache; then
                          gtk-update-icon-cache -f -t "$theme_dir" 2>/dev/null || true
                          print_success "Updated icon cache for $theme_name"
                      fi
                  fi
              done
          fi
      done
  }

  # Function to reload dconf settings
  reload_dconf() {
      if command_exists dconf; then
          print_status "Reloading dconf settings..."
          dconf reset -f /org/gnome/desktop/interface/ || true

          # Reapply GTK theme settings
          dconf write /org/gnome/desktop/interface/gtk-theme "'WhiteSur-Dark'"
          dconf write /org/gnome/desktop/interface/icon-theme "'WhiteSur-dark'"
          dconf write /org/gnome/desktop/interface/cursor-theme "'Bibata-Modern-Ice'"
          dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
          dconf write /org/gnome/desktop/interface/font-name "'Noto Sans 11'"

          print_success "Reloaded dconf settings"
      else
          print_warning "dconf not available, skipping dconf reload"
      fi
  }

  # Function to reload GTK settings
  reload_gtk_settings() {
      print_status "Reloading GTK settings..."

      # Signal GTK applications to reload settings
      if [ "$WAYLAND_SESSION" = true ]; then
          # For Wayland, we need to use different methods
          if command_exists gsettings; then
              gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark'
              gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'
              gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
              print_success "Applied settings via gsettings"
          fi
      else
          # For X11, we can use xsettingsd or similar
          if command_exists xrdb; then
              echo "Xft.antialias: 1" | xrdb -merge
              echo "Xft.hinting: 1" | xrdb -merge
              echo "Xft.hintstyle: hintfull" | xrdb -merge
              echo "Xft.rgba: rgb" | xrdb -merge
              print_success "Updated X11 font rendering settings"
          fi
      fi
  }

  # Function to verify theme files exist
  verify_theme_files() {
      print_status "Verifying theme files..."

      local theme_dirs=(
          "$HOME/.themes"
          "$HOME/.local/share/themes"
          "$HOME/.nix-profile/share/themes"
          "/run/current-system/sw/share/themes"
          "/usr/share/themes"
      )

      local theme_found=false
      for theme_dir in "''${theme_dirs[@]}"; do
          if [ -d "$theme_dir/WhiteSur-Dark" ]; then
              print_success "Found WhiteSur-Dark theme in $theme_dir"
              theme_found=true
              break
          fi
      done

      if [ "$theme_found" = false ]; then
          print_error "WhiteSur-Dark theme not found in any theme directory"
          print_status "Available theme directories:"
          for theme_dir in "''${theme_dirs[@]}"; do
              if [ -d "$theme_dir" ]; then
                  echo "  - $theme_dir"
                  if [ -d "$theme_dir" ]; then
                      ls -la "$theme_dir" | grep -E '^d' | head -5
                  fi
              fi
          done
          return 1
      fi

      # Check icon theme
      local icon_dirs=(
          "$HOME/.icons"
          "$HOME/.local/share/icons"
          "$HOME/.nix-profile/share/icons"
          "/run/current-system/sw/share/icons"
          "/usr/share/icons"
      )

      local icon_found=false
      for icon_dir in "''${icon_dirs[@]}"; do
          if [ -d "$icon_dir/WhiteSur-dark" ]; then
              print_success "Found WhiteSur-dark icons in $icon_dir"
              icon_found=true
              break
          fi
      done

      if [ "$icon_found" = false ]; then
          print_warning "WhiteSur-dark icon theme not found"
      fi
  }

  # Function to show theme status
  show_theme_status() {
      print_status "Current theme status:"
      echo ""

      if command_exists gsettings; then
          echo "GTK Theme: $(gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null || echo 'Not set')"
          echo "Icon Theme: $(gsettings get org.gnome.desktop.interface icon-theme 2>/dev/null || echo 'Not set')"
          echo "Cursor Theme: $(gsettings get org.gnome.desktop.interface cursor-theme 2>/dev/null || echo 'Not set')"
          echo "Color Scheme: $(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null || echo 'Not set')"
      fi

      echo ""
      echo "Environment Variables:"
      echo "GTK_THEME: ''${GTK_THEME:-'Not set'}"
      echo "XCURSOR_THEME: ''${XCURSOR_THEME:-'Not set'}"
      echo "QT_QPA_PLATFORMTHEME: ''${QT_QPA_PLATFORMTHEME:-'Not set'}"
      echo ""
  }

  # Function to test theme application
  test_theme_application() {
      print_status "Testing theme application..."

      if command_exists gtk3-demo; then
          print_status "You can test GTK3 theming with: gtk3-demo"
      fi

      if command_exists gtk4-demo; then
          print_status "You can test GTK4 theming with: gtk4-demo"
      fi

      if command_exists lxappearance; then
          print_status "You can configure themes with: lxappearance"
      fi
  }

  # Main execution
  main() {
      case "''${1:-}" in
          "status")
              show_theme_status
              ;;
          "verify")
              verify_theme_files
              ;;
          "test")
              test_theme_application
              ;;
          "clean")
              clear_gtk_caches
              update_icon_cache
              ;;
          "reload"|"reset"|"")
              print_status "Starting GTK theme reset and reload..."

              # Verify theme files exist
              if ! verify_theme_files; then
                  print_error "Theme verification failed. Please check your theme installation."
                  exit 1
              fi

              # Clear caches
              clear_gtk_caches

              # Update icon cache
              update_icon_cache

              # Reload settings
              reload_dconf
              reload_gtk_settings

              # Restart applications
              restart_gtk_apps

              print_success "GTK theme reset and reload completed!"
              print_status "You may need to restart some applications to see changes."
              ;;
          "help"|"-h"|"--help")
              echo "Usage: gtk-theme-reset [command]"
              echo ""
              echo "Commands:"
              echo "  reload, reset, (empty)  - Reset and reload GTK themes (default)"
              echo "  status                  - Show current theme status"
              echo "  verify                  - Verify theme files exist"
              echo "  clean                   - Clear caches only"
              echo "  test                    - Show theme testing commands"
              echo "  help                    - Show this help message"
              echo ""
              echo "Examples:"
              echo "  gtk-theme-reset         # Full reset and reload"
              echo "  gtk-theme-reset status  # Show current status"
              echo "  gtk-theme-reset clean   # Clear caches only"
              ;;
          *)
              print_error "Unknown command: $1"
              echo "Use 'gtk-theme-reset help' for usage information."
              exit 1
              ;;
      esac
  }

  # Run main function with all arguments
  main "$@"
''
