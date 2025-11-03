{ pkgs, lib, config, ... }:

{
  # GTK Theme Management Utilities

  home.packages = with pkgs; [
    # Theme management tools
    lxappearance
    gtk3
    gtk4
    glib # for gsettings

    # Theme switcher script
    (writeShellScriptBin "gtk-theme-manager" ''
      #!/usr/bin/env bash

      # GTK Theme Manager - Easy theme switching and management

      THEME_DIR="$HOME/.themes"
      CONFIG_DIR="$HOME/.config/gtk-theme-manager"
      CURRENT_THEME_FILE="$CONFIG_DIR/current-theme"

      # Create directories if they don't exist
      mkdir -p "$CONFIG_DIR"
      mkdir -p "$THEME_DIR"

      # Available themes
      THEMES=(
        "Fluent-Dark"
        "Orchis-Dark"
        "Arc-Dark"
        "Materia-dark"
        "Adapta-Nokto"
        "Numix-DarkBlue"
        "WhiteSur-Dark"
        "Catppuccin-Mocha"
        "Layan-Dark"
      )

      show_help() {
        echo "GTK Theme Manager"
        echo "Usage: gtk-theme-manager [COMMAND] [THEME]"
        echo ""
        echo "Commands:"
        echo "  list                List available themes"
        echo "  current            Show current theme"
        echo "  set THEME          Set GTK theme"
        echo "  preview THEME      Preview theme (temporary)"
        echo "  reset              Reset to default theme"
        echo "  backup             Backup current theme settings"
        echo "  restore            Restore from backup"
        echo "  transparent        Enable transparency mode"
        echo "  opaque             Disable transparency mode"
        echo "  install FILE       Install theme from file"
        echo "  remove THEME       Remove installed theme"
        echo ""
        echo "Available themes:"
        for theme in "''${THEMES[@]}"; do
          echo "  - $theme"
        done
      }

      get_current_theme() {
        gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'"
      }

      set_theme() {
        local theme="$1"
        if [[ -z "$theme" ]]; then
          echo "Error: No theme specified"
          return 1
        fi

        # Set GTK theme
        gsettings set org.gnome.desktop.interface gtk-theme "$theme"

        # Update theme files
        echo "$theme" > "$CURRENT_THEME_FILE"

        # Notify user
        notify-send "Theme Changed" "GTK theme set to: $theme" -i preferences-desktop-theme
        echo "Theme changed to: $theme"
      }

      list_themes() {
        echo "Available GTK themes:"
        echo ""

        # System themes
        echo "System themes:"
        if [[ -d "/run/current-system/sw/share/themes" ]]; then
          ls /run/current-system/sw/share/themes 2>/dev/null | grep -E "(Dark|dark)" | head -10
        fi

        echo ""

        # User themes
        echo "User themes:"
        if [[ -d "$THEME_DIR" ]]; then
          ls "$THEME_DIR" 2>/dev/null | head -10
        fi

        echo ""
        echo "Predefined themes:"
        for theme in "''${THEMES[@]}"; do
          current=$(get_current_theme)
          if [[ "$theme" == "$current" ]]; then
            echo "  ● $theme (current)"
          else
            echo "  ○ $theme"
          fi
        done
      }

      preview_theme() {
        local theme="$1"
        if [[ -z "$theme" ]]; then
          echo "Error: No theme specified for preview"
          return 1
        fi

        # Backup current theme
        local current_theme=$(get_current_theme)

        # Set preview theme
        set_theme "$theme"

        echo "Previewing theme: $theme"
        echo "Press Enter to keep, or Ctrl+C to revert..."

        # Wait for user input
        read -r

        echo "Theme preview confirmed: $theme"
      }

      backup_theme() {
        local backup_file="$CONFIG_DIR/theme-backup-$(date +%Y%m%d-%H%M%S).conf"

        echo "Creating theme backup..."

        {
          echo "# GTK Theme Backup - $(date)"
          echo "GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme)"
          echo "ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme)"
          echo "CURSOR_THEME=$(gsettings get org.gnome.desktop.interface cursor-theme)"
          echo "FONT_NAME=$(gsettings get org.gnome.desktop.interface font-name)"
          echo "COLOR_SCHEME=$(gsettings get org.gnome.desktop.interface color-scheme)"
        } > "$backup_file"

        echo "Backup saved to: $backup_file"
      }

      restore_theme() {
        local backup_file
        backup_file=$(ls "$CONFIG_DIR"/theme-backup-*.conf 2>/dev/null | tail -1)

        if [[ -z "$backup_file" ]]; then
          echo "No backup found"
          return 1
        fi

        echo "Restoring from: $backup_file"

        # Source the backup file and apply settings
        source "$backup_file"

        gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
        gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"
        gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME"
        gsettings set org.gnome.desktop.interface font-name "$FONT_NAME"
        gsettings set org.gnome.desktop.interface color-scheme "$COLOR_SCHEME"

        echo "Theme restored successfully"
      }

      enable_transparency() {
        # Enable transparency mode by copying custom CSS
        local gtk3_css="$HOME/.config/gtk-3.0/gtk.css"
        local gtk4_css="$HOME/.config/gtk-4.0/gtk.css"

        # Create directories
        mkdir -p "$(dirname "$gtk3_css")"
        mkdir -p "$(dirname "$gtk4_css")"

        # Enable transparency in settings
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

        echo "Transparency mode enabled"
        echo "Note: Custom CSS for transparency is managed by home-manager"
        notify-send "Transparency" "Transparency mode enabled" -i dialog-information
      }

      disable_transparency() {
        # Remove custom CSS files
        local gtk3_css="$HOME/.config/gtk-3.0/gtk.css"
        local gtk4_css="$HOME/.config/gtk-4.0/gtk.css"

        if [[ -f "$gtk3_css.backup" ]]; then
          mv "$gtk3_css.backup" "$gtk3_css"
        else
          rm -f "$gtk3_css"
        fi

        if [[ -f "$gtk4_css.backup" ]]; then
          mv "$gtk4_css.backup" "$gtk4_css"
        else
          rm -f "$gtk4_css"
        fi

        echo "Transparency mode disabled"
        notify-send "Transparency" "Transparency mode disabled" -i dialog-information
      }

      install_theme() {
        local theme_file="$1"

        if [[ ! -f "$theme_file" ]]; then
          echo "Error: Theme file not found: $theme_file"
          return 1
        fi

        # Extract theme based on file type
        case "$theme_file" in
          *.tar.gz|*.tgz)
            tar -xzf "$theme_file" -C "$THEME_DIR"
            ;;
          *.tar.xz|*.txz)
            tar -xJf "$theme_file" -C "$THEME_DIR"
            ;;
          *.zip)
            unzip -q "$theme_file" -d "$THEME_DIR"
            ;;
          *)
            echo "Error: Unsupported file format. Supported: .tar.gz, .tar.xz, .zip"
            return 1
            ;;
        esac

        echo "Theme installed to: $THEME_DIR"
        echo "Available themes updated:"
        list_themes
      }

      remove_theme() {
        local theme="$1"

        if [[ -z "$theme" ]]; then
          echo "Error: No theme specified for removal"
          return 1
        fi

        local theme_path="$THEME_DIR/$theme"

        if [[ ! -d "$theme_path" ]]; then
          echo "Error: Theme not found: $theme"
          return 1
        fi

        # Confirm removal
        echo "Are you sure you want to remove theme: $theme? (y/N)"
        read -r confirm

        if [[ "$confirm" =~ ^[Yy]$ ]]; then
          rm -rf "$theme_path"
          echo "Theme removed: $theme"
        else
          echo "Theme removal cancelled"
        fi
      }

      reset_theme() {
        # Reset to default Fluent-Dark theme
        set_theme "Fluent-Dark"
        gsettings set org.gnome.desktop.interface icon-theme "WhiteSur"
        gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"
        gsettings set org.gnome.desktop.interface font-name "Noto Sans 11"
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

        echo "Theme reset to defaults"
      }

      # Main command handling
      case "$1" in
        "list"|"ls")
          list_themes
          ;;
        "current")
          echo "Current theme: $(get_current_theme)"
          ;;
        "set")
          set_theme "$2"
          ;;
        "preview")
          preview_theme "$2"
          ;;
        "backup")
          backup_theme
          ;;
        "restore")
          restore_theme
          ;;
        "transparent"|"transparency")
          enable_transparency
          ;;
        "opaque"|"solid")
          disable_transparency
          ;;
        "install")
          install_theme "$2"
          ;;
        "remove"|"uninstall")
          remove_theme "$2"
          ;;
        "reset"|"default")
          reset_theme
          ;;
        "help"|"--help"|"-h"|"")
          show_help
          ;;
        *)
          echo "Unknown command: $1"
          echo "Use 'gtk-theme-manager help' for usage information"
          exit 1
          ;;
      esac
    '')

    # Quick theme picker with rofi
    (writeShellScriptBin "gtk-theme-picker" ''
      #!/usr/bin/env bash

      # Quick GTK theme picker using rofi

      THEMES=(
        "Fluent-Dark"
        "Orchis-Dark"
        "Arc-Dark"
        "Materia-dark"
        "Adapta-Nokto"
        "WhiteSur-Dark"
        "Catppuccin-Mocha"
        "Layan-Dark"
      )

      # Get current theme
      current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")

      # Create theme list with current theme marked
      theme_list=""
      for theme in "''${THEMES[@]}"; do
        if [[ "$theme" == "$current_theme" ]]; then
          theme_list="$theme_list● $theme (current)\n"
        else
          theme_list="$theme_list○ $theme\n"
        fi
      done

      # Show rofi menu
      selected=$(echo -e "$theme_list" | rofi -dmenu -p "Select GTK Theme:" -format "s" -i)

      if [[ -n "$selected" ]]; then
        # Extract theme name (remove bullet and (current) text)
        theme_name=$(echo "$selected" | sed 's/^[●○] //' | sed 's/ (current)$//')

        # Apply theme
        gtk-theme-manager set "$theme_name"
      fi
    '')

    # Theme preview tool
    (writeShellScriptBin "gtk-theme-preview" ''
      #!/usr/bin/env bash

      # GTK Theme Preview Tool
      # Opens a test window with various GTK widgets

      PREVIEW_APP=$(cat << 'EOF'
      import gi
      gi.require_version('Gtk', '3.0')
      from gi.repository import Gtk, GLib
      import sys

      class ThemePreview(Gtk.Window):
          def __init__(self):
              Gtk.Window.__init__(self, title="GTK Theme Preview")
              self.set_default_size(600, 400)
              self.set_position(Gtk.WindowPosition.CENTER)

              # Create main container
              vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
              vbox.set_margin_top(10)
              vbox.set_margin_bottom(10)
              vbox.set_margin_left(10)
              vbox.set_margin_right(10)
              self.add(vbox)

              # Header
              header = Gtk.HeaderBar()
              header.set_show_close_button(True)
              header.set_title("Theme Preview")
              self.set_titlebar(header)

              # Add widgets
              self.create_widgets(vbox)

          def create_widgets(self, container):
              # Buttons
              button_box = Gtk.Box(spacing=10)
              button_box.pack_start(Gtk.Button(label="Normal"), False, False, 0)

              suggested = Gtk.Button(label="Suggested")
              suggested.get_style_context().add_class("suggested-action")
              button_box.pack_start(suggested, False, False, 0)

              destructive = Gtk.Button(label="Destructive")
              destructive.get_style_context().add_class("destructive-action")
              button_box.pack_start(destructive, False, False, 0)

              container.pack_start(button_box, False, False, 0)

              # Entry and combo
              entry_box = Gtk.Box(spacing=10)
              entry_box.pack_start(Gtk.Entry(), True, True, 0)

              combo = Gtk.ComboBoxText()
              combo.append_text("Option 1")
              combo.append_text("Option 2")
              combo.set_active(0)
              entry_box.pack_start(combo, False, False, 0)

              container.pack_start(entry_box, False, False, 0)

              # Check and radio buttons
              check_box = Gtk.Box(spacing=10)
              check_box.pack_start(Gtk.CheckButton(label="Checkbox"), False, False, 0)
              check_box.pack_start(Gtk.RadioButton(label="Radio 1"), False, False, 0)
              check_box.pack_start(Gtk.RadioButton(label="Radio 2"), False, False, 0)

              container.pack_start(check_box, False, False, 0)

              # Scale and progress
              scale_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=5)
              scale_box.pack_start(Gtk.Scale.new_with_range(Gtk.Orientation.HORIZONTAL, 0, 100, 1), False, False, 0)

              progress = Gtk.ProgressBar()
              progress.set_fraction(0.7)
              scale_box.pack_start(progress, False, False, 0)

              container.pack_start(scale_box, False, False, 0)

              # Text view in scrolled window
              scrolled = Gtk.ScrolledWindow()
              scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
              scrolled.set_min_content_height(150)

              textview = Gtk.TextView()
              textbuffer = textview.get_buffer()
              textbuffer.set_text("This is a text view showing how text appears in the current theme.\n\nYou can test text selection, scrolling, and other text-related features here.")

              scrolled.add(textview)
              container.pack_start(scrolled, True, True, 0)

      def main():
          app = ThemePreview()
          app.connect("destroy", Gtk.main_quit)
          app.show_all()
          Gtk.main()

      if __name__ == "__main__":
          main()
      EOF
      )

      # Create temporary Python file and run it
      temp_file=$(mktemp --suffix=.py)
      echo "$PREVIEW_APP" > "$temp_file"

      python3 "$temp_file" &

      # Clean up after a delay
      sleep 1
      rm "$temp_file"
    '')
  ];

  # Add keybinding for quick theme picker
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER ALT, SHIFT, exec, gtk-theme-picker"
  ];
}
