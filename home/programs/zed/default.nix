{ pkgs, ... }:

{
  # Zed settings
  home.file.".config/zed/settings.json".text = ''
    {
      "icon_theme": "Material Icon Theme",
      "ui_font_size": 16,
      "buffer_font_size": 15,
      "vim_mode": true,
      "theme": {
        "mode": "dark",
        "light": "One Light",
        "dark": "One Dark Pro Max"
      },
      "languages": {
        "Python": {
          "language_servers": ["pylsp"],
          "formatter": {
            "external": {
              "command": "black",
              "arguments": ["-"]
            }
          }
        }
      }
    }
  '';

  # Keymap configuration
  home.file.".config/zed/keymap.json".text = ''
    [
      {
        "context": "Workspace",
        "bindings": {
          "ctrl-shift-a": "editor::SelectAll"
        }
      },
      {
        "context": "Editor",
        "bindings": {
          "ctrl-shift-v": "editor::Paste",
          "ctrl-shift-a": "editor::SelectAll"
        }
      },
      {
        "context": "Editor && vim_mode == insert",
        "bindings": {
        }
      }
    ]
  '';
}
