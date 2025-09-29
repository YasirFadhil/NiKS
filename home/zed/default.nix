{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zed
  ];

  # Zed settings
  home.file.".config/zed/settings.json".text = ''
    {
      "theme": "One Dark",
      "vim_mode": true,
      "tab_size": 2,
      "relative_line_numbers": true,
      "format_on_save": true,
      "auto_update": true,
      "telemetry": false,
      "terminal": {
        "font_family": "JetBrainsMono Nerd Font",
        "font_size": 14,
        "blinking": "off"
      },
      "languages": {
        "Nix": {
          "tab_size": 2,
          "formatter": "nixpkgs-fmt"
        }
      }
    }
  '';

  # Keymap configuration
  home.file.".config/zed/keymap.json".text = ''
    {
      "normal": {
        "j": "move_down",
        "k": "move_up",
        "h": "move_left",
        "l": "move_right",
        "ctrl-s": "workspace::save_active_item",
        "ctrl-p": "file_finder::toggle",
        "ctrl-/": "workspace::toggle_comment"
      },
      "insert": {
        "ctrl-s": "workspace::save_active_item",
        "ctrl-space": "editor::trigger_completions"
      }
    }
  '';
}
