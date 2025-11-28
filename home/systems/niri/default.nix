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
          accel-speed = 0.8;
        };
      };

      # Output configuration
      outputs = {
        "eDP-1" = {
          mode = {
            width = 1366;
            height = 768;
            refresh = 60.0;
          };
          position = { x = 0; y = 0; };
          scale = 1.0;
          #scale = 0.85;
        };
      };

      # Layout settings
      layout = {
        gaps = 15;
        always-center-single-column = true;
        preset-column-widths = [
          { proportion = 0.333; }
          { proportion = 0.5; }
          { proportion = 0.667; }
        ];
        default-column-width = { proportion = 0.6; };
        focus-ring = {
          enable = true;
          width = 1;
          active.color = "rgb(59 130 246)";
          inactive.color = "rgb(89 89 89)";
        };
        border = {
          enable = true;
          width = 1;
          active.color = "rgb(59 130 246)";
          inactive.color = "rgba(89, 89, 89, 0.5)";
        };
      };

      # Window rules
      window-rules = [
        {
          matches = [
            {is-window-cast-target = true;}
          ];
          focus-ring = {
            active = {color = "#f38ba8";};
            inactive = {color = "#7d0d2d";};
          };
          border = {
            inactive = {color = "#7d0d2d";};
          };
          shadow = {
            color = "#7d0d2d70";
          };
          tab-indicator = {
            active = {color = "#f38ba8";};
            inactive = {color = "#7d0d2d";};
          };
        }
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
      ];

      # Animations
      animations = {
        slowdown = 1.0;

        window-open = {
          kind.spring = {
            damping-ratio = 0.8;
            stiffness = 1000;
            epsilon = 0.0001;
          };
        };

        config-notification-open-close = {
          kind.spring = {
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
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_DESKTOP = "niri";
      };

      # Spawn at startup
      spawn-at-startup = [
        { command = ["polkit-gnome-authentication-agent-1"]; }
        { command = ["gnome-keyring-daemon" "--start" "--components=pkcs11,secrets,ssh,pgp"]; }
        { command = ["nm-applet"]; }
        { command = ["blueman-applet"]; }
        { command = ["swaybg" "-m" "fill" "-i" "./themes/wallpaper.jpg"]; }
        { command = ["xwayland-satellite"]; }
        { command = ["kdeconnect-indicator"]; }
        { command = ["clipboard-manager" "store-text"]; }
        { command = ["clipboard-manager" "store-image"]; }
      ];

      # Cursor settings
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 20;
      };

      # Screenshot settings
      screenshot-path = "~/Pictures/Screenshots/Screenshot_niri_%Y-%m-%d %H-%M-%S.png";

      # Hotkey daemon
      hotkey-overlay = {
        skip-at-startup = false;
      };

      # Prefer no CSD
      prefer-no-csd = true;

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

      # Applications
      "Mod+T".action.spawn = "ghostty";
      "Mod+D".action.spawn = "rofi-launcher";
      "Mod+E".action.spawn = "nautilus";
      "Mod+W".action.spawn = "waypaper";

      # Media keys
      "XF86AudioRaiseVolume".action.spawn = ["volume-control" "up"];
      "XF86AudioLowerVolume".action.spawn = ["volume-control" "down"];
      "XF86AudioMute".action.spawn = ["volume-control" "mute"];
      "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "5%+"];
      "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];

      # Screenshots
      "Mod+Shift+S".action.screenshot = {};
      "Mod+S".action.screenshot-screen = {};
      "Mod+Alt+S".action.screenshot-window = {};

      # System
      "Mod+Shift+Q".action.quit = {};
      "Mod+P".action.spawn = ["wlogout"];
      "Mod+Shift+P".action.power-off-monitors = {};
      "Mod+Shift+L".action.spawn = ["swaylock-blur"];

      # Clipboard
      "Mod+Shift+V".action.spawn = ["clipboard-manager" "show"];
      "Mod+Alt+C".action.spawn = ["clipboard-manager" "clear"];

      # Scratchpad
      "Mod+Shift+Minus".action.move-window-to-workspace = "scratchpad";
      "Mod+Minus".action.focus-workspace = "scratchpad";
      };
    };
  };
}
