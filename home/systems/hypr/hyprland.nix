{ inputs, pkgs, lib, ... }:

let
  myPackages = import ../../package.nix { inherit pkgs; };
in
{
  imports = [
    ./polkitagent.nix
    ./binds.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./env.nix
    ./animation.nix
  ];

  home.packages = myPackages;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      # Monitor configuration
      monitor = [
        "eDP-1,1700x950@60,0x0,1" #change this to your exact monitor resolution
      ];

      # Autostart applications
      exec-once = [
        # Authentication and security
        "polkit-gnome-authentication-agent-1"
        "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,pgp"

        # System utilities
        "caffeine"
        "hypridle &"
        "nm-applet &"
        "blueman-applet &"

        # Desktop components
        "hyprpaper &"
        "waypaper --restore"
        "kdeconnect-indicator"
        "nwg-dock-hyprland -r -i 30 -ml 12 -mr 12 -mb 12 -nolauncher -x -l bottom"

        # Clipboard management
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        # Cursor settings
        "hyprctl setcursor Bibata-Modern-Ice 20"
      ];

      # Input configuration
      input = {
        kb_model = "chromebook"; #you can change this to your keyboard model
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0.5;
        repeat_delay = 300;
        repeat_rate = 50;

        touchpad = {
          natural_scroll = true;
        };
      };

      # General appearance
      general = {
        # Gaps
        gaps_in = 7;
        gaps_out = 15;
        gaps_workspaces = 50;

        # Borders
        border_size = 0;
        "col.active_border" = "rgb(4575da) rgb(6804b5)";
        "col.inactive_border" = "rgb(595959)";
      };

      # Window decoration
      decoration = {
        # Opacity
        active_opacity = 0.75;
        inactive_opacity = 0.73;

        # Window appearance
        rounding = 14;

        # Blur effect
        blur = {
          enabled = true;
          size = 8;        # Higher = thicker blur (range: 18-32)
          passes = 3;      # Higher = smoother blur (range: 4-8)
          vibrancy = 0.33; # Higher = more underlying color (range: 0.22-0.4)
        };

        # Dimming
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
      };

      # Layout settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Miscellaneous
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      # Window rules
      windowrule = [
        # Volume Control
        "float, title:^(Volume Control)$"
        "size 872 515, title:^(Volume Control)$"

        # Calculator
        "float, class:^(org.gnome.Calculator)$"
        "size 567 734, class:^(org.gnome.Calculator)$"

        # Waypaper
        "float, title:^(Waypaper)$"

        # KDE Connect
        "float, title:^(KDE Connect)$"
        "float, title:^(WhatsApp — KDE Connect Daemon)$"
        "float, class:^(org.kde.kdeconnect.daemon)$"
        "size 1035 661, title:^(KDE Connect)$"

        # Floating terminal
        "float,class:^(floating-kitty)$"
        "size 1094 633,class:^(floating-kitty)$"
        # "float,class:^(floating-term)$"
        # "size 1094 633,class:^(floating-ghostty)$"
      ];
    };
  };
}
