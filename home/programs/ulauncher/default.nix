{ pkgs, ... }:

{
  # Create ulauncher config directory and settings
  home.file.".config/ulauncher/settings.json".text = builtins.toJSON {
    blacklisted-desktop-dirs = "/usr/share/locale:/usr/share/app-install:/usr/share/kservices5:/usr/share/fk5:/usr/share/kservicetypes5:/usr/share/applications/screensavers:/usr/share/kde4:/usr/share/mimelnk";
    clear-previous-query = true;
    disable-desktop-filters = false;
    grab-mouse-pointer = false;
    hotkey-show-app = "<Primary>space";
    render-on-screen = "mouse-pointer-monitor";
    show-indicator-icon = true;
    show-recent-apps = "0";
    terminal-command = "kitty";
    theme-name = "dark";
    show-app-desktop-actions = false;
    app-autohide-after-open = false;
    app-startup-delay = 0;
    app-max-width = 600;
  };

  # Create ulauncher shortcuts
  home.file.".config/ulauncher/shortcuts.json".text = builtins.toJSON {
    "f4ac4abd-9919-4d5c-9c0a-2c0c6dcf2c2f" = {
      id = "f4ac4abd-9919-4d5c-9c0a-2c0c6dcf2c2f";
      name = "Google Search";
      keyword = "g";
      cmd = "https://google.com/search?q=%s";
      icon = "/usr/share/pixmaps/google-chrome.png";
      is_default_search = true;
      run_without_argument = false;
      added = 1;
    };
    "f4ac4abd-9919-4d5c-9c0a-2c0c6dcf2c3f" = {
      id = "f4ac4abd-9919-4d5c-9c0a-2c0c6dcf2c3f";
      name = "Calculator";
      keyword = "calc";
      cmd = "= %s";
      icon = "/usr/share/pixmaps/gnome-calculator.png";
      is_default_search = false;
      run_without_argument = false;
      added = 2;
    };
  };

  # Custom CSS styling for ulauncher to match your theme
  home.file.".config/ulauncher/user-themes/custom-dark/manifest.json".text = builtins.toJSON {
    manifest_version = "1";
    name = "Custom Dark";
    display_name = "Custom Dark Theme";
    extend_theme = "dark";
    css_file = "theme.css";
    matched_text_hl_colors = {
      when_selected = "#61AFEF";
      when_not_selected = "#98C379";
    };
  };

  home.file.".config/ulauncher/user-themes/custom-dark/theme.css".text = ''
    .app {
      background-color: rgba(29, 14, 46, 0.95);
      border: none;
      border-radius: 24px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
    }

    .input {
      background-color: rgba(25, 10, 34, 0.8);
      border: none;
      border-radius: 14px;
      padding: 13px 16px;
      margin: 25px 24px 10px 24px;
      color: #cdd6f4;
      font-family: "JetBrains Mono Nerd Font";
      font-size: 13px;
      caret-color: #61AFEF;
    }

    .input:focus {
      border: 1px solid #61AFEF;
      box-shadow: 0 0 10px rgba(97, 175, 239, 0.3);
    }

    .item-box {
      background-color: rgba(47, 40, 51, 0.6);
      border-radius: 10px;
      margin: 0px 24px 11px 24px;
      padding: 10px 14px;
    }

    .item-box:hover,
    .item-box.selected {
      background-color: rgba(29, 21, 32, 0.9);
      border: 1px solid #61AFEF;
    }

    .item-name {
      color: #cdd6f4;
      font-family: "JetBrains Mono Nerd Font";
      font-size: 13px;
      font-weight: normal;
    }

    .item-shortcut {
      color: #9d88b0;
      font-family: "JetBrains Mono Nerd Font";
      font-size: 11px;
    }

    .selected .item-name {
      color: #cdd6f4;
    }

    .selected .item-shortcut {
      color: #61AFEF;
    }
  '';

  # Enable ulauncher service
  systemd.user.services.ulauncher = {
    Unit = {
      Description = "Ulauncher";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
