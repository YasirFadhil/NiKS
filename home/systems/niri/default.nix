{ inputs, pkgs, lib, config, ... }:

let
  myPackages = import ../../package.nix { inherit pkgs; };
in
{
  imports = [
    inputs.niri.homeModules.niri
  ];

  home.packages = myPackages;

  programs.niri = {
    enable = true;

    settings = {
      # Input configuration
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            model = "chromebook";
          };
          repeat-delay = 300;
          repeat-rate = 50;
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
        };

        mouse = {
          sensitivity = 0.5;
        };
      };

      # Output configuration
      outputs = {
        "eDP-1" = {
          mode = "1700x950@60";
          position = { x = 0; y = 0; };
          scale = 1.0;
        };
      };

      # Layout settings
      layout = {
        gaps = 15;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 1.0/3.0; }
          { proportion = 1.0/2.0; }
          { proportion = 2.0/3.0; }
        ];
        default-column-width = { proportion = 1.0/2.0; };
        focus-ring = {
          enable = true;
          width = 2;
          active-color = "rgb(75 117 218)";
          inactive-color = "rgb(89 89 89)";
        };
        border = {
          enable = false;
        };
      };

      # Window rules
      window-rules = [
        {
          matches = [{ app-id = "^org\\.gnome\\.Calculator$"; }];
          default-column-width = { fixed = 567; };
          open-floating = true;
        }
        {
          matches = [{ title = "^Volume Control$"; }];
          default-column-width = { fixed = 872; };
          open-floating = true;
        }
        {
          matches = [{ app-id = "^floating-kitty$"; }];
          default-column-width = { fixed = 1094; };
          open-floating = true;
        }
      ];

      # Animations
      animations = {
        slowdown = 1.0;
        spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };

        window-open = {
          spring = {
            damping-ratio = 0.8;
            stiffness = 1000;
            epsilon = 0.0001;
          };
          duration-ms = 250;
        };

        config-notification-open-close = {
          spring = {
            damping-ratio = 0.6;
            stiffness = 1000;
            epsilon = 0.001;
          };
        };
      };

      # Environment variables
      environment = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "20";
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_DESKTOP = "niri";
      };

      # Spawn at startup
      spawn-at-startup = [
        { command = ["polkit-gnome-authentication-agent-1"]; }
        { command = ["gnome-keyring-daemon" "--start" "--components=pkcs11,secrets,ssh,pgp"]; }
        { command = ["caffeine"]; }
        { command = ["nm-applet"]; }
        { command = ["blueman-applet"]; }
        { command = ["waypaper" "--restore"]; }
        { command = ["kdeconnect-indicator"]; }
        { command = ["wl-paste" "--type" "text" "--watch" "cliphist" "store"]; }
        { command = ["wl-paste" "--type" "image" "--watch" "cliphist" "store"]; }
      ];

      # Cursor settings
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 20;
      };

      # Screenshot settings
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      # Hotkey daemon
      hotkey-overlay = {
        skip-at-startup = true;
      };

      # Prefer no CSD
      prefer-no-csd = true;
    };

    # Key bindings
    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = {};

      # Movement
      "Mod+Left".action.focus-column-left = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+H".action.focus-column-left = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};
      "Mod+L".action.focus-column-right = {};

      # Moving windows
      "Mod+Ctrl+Left".action.move-column-left = {};
      "Mod+Ctrl+Down".action.move-window-down = {};
      "Mod+Ctrl+Up".action.move-window-up = {};
      "Mod+Ctrl+Right".action.move-column-right = {};
      "Mod+Ctrl+H".action.move-column-left = {};
      "Mod+Ctrl+J".action.move-window-down = {};
      "Mod+Ctrl+K".action.move-window-up = {};
      "Mod+Ctrl+L".action.move-column-right = {};

      # Workspaces
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+0".action.focus-workspace = 10;

      # Moving to workspaces
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;
      "Mod+Shift+0".action.move-column-to-workspace = 10;

      # Window management
      "Mod+Q".action.close-window = {};
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};
      "Mod+Space".action.center-column = {};

      # Column width
      "Mod+R".action.switch-preset-column-width = {};
      "Mod+Shift+R".action.reset-window-height = {};
      "Mod+Ctrl+R".action.toggle-window-height = {};

      # Applications
      "Mod+T".action.spawn = "kitty";
      "Mod+Return".action.spawn = "kitty";
      "Mod+D".action.spawn = "anyrun";
      "Mod+E".action.spawn = "nautilus";

      # Media keys
      "XF86AudioRaiseVolume".action.spawn = ["pactl" "set-sink-volume" "@DEFAULT_SINK@" "+5%"];
      "XF86AudioLowerVolume".action.spawn = ["pactl" "set-sink-volume" "@DEFAULT_SINK@" "-5%"];
      "XF86AudioMute".action.spawn = ["pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle"];
      "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "5%+"];
      "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];

      # Screenshots
      "Print".action.screenshot = {};
      "Ctrl+Print".action.screenshot-screen = {};
      "Alt+Print".action.screenshot-window = {};

      # System
      "Mod+Shift+E".action.quit = {};
      "Mod+Shift+P".action.power-off-monitors = {};

      # Scratchpad
      "Mod+Shift+Minus".action.move-window-to-workspace = "scratchpad";
      "Mod+Minus".action.toggle-window-from-scratchpad = {};
    };
  };
}
