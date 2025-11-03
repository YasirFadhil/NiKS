{ lib, ... }:

{
  # Transparency configuration for Hyprland
  # This module provides easy control over window transparency and blur effects

  wayland.windowManager.hyprland.settings = {
    # Enhanced decoration settings for transparency
    decoration = {
      # Global transparency settings
      active_opacity = 0.85;    # Transparency for focused windows (0.0 = fully transparent, 1.0 = opaque)
      inactive_opacity = 0.75;  # Transparency for unfocused windows

      # Advanced blur configuration
      blur = {
        enabled = true;
        size = 20;              # Blur radius (higher = more blur)
        passes = 4;             # Number of blur passes (higher = smoother but more resource intensive)
        vibrancy = 0.35;        # Color vibrancy through blur
        ignore_opacity = false; # Allow blur to work with transparency
        new_optimizations = true; # Enable performance optimizations
        xray = false;           # Disable xray effect (transparent windows show desktop)
        brightness = 1.0;       # Blur brightness multiplier
        contrast = 1.0;         # Blur contrast multiplier
        noise = 0.02;          # Add subtle noise to blur (helps with banding)
      };

      # Shadow effects (complement transparency well)
      drop_shadow = true;
      shadow_range = 15;
      shadow_render_power = 2;
      "col.shadow" = "rgba(1a1a1aaa)";
      shadow_offset = "0 5";
    };

    # Comprehensive window rules for transparency control
    windowrulev2 = [
      # Global transparency for all windows
      "opacity 0.85 0.75,class:.*"

      # Exceptions - Keep these applications opaque for better usability
      "opaque,class:^(firefox)$"
      "opaque,class:^(zen-alpha)$"
      "opaque,class:^(zen-browser)$"
      "opaque,class:^(chromium)$"
      "opaque,class:^(google-chrome)$"
      "opaque,class:^(brave-browser)$"

      # Media applications - should be opaque for better viewing
      "opaque,class:^(mpv)$"
      "opaque,class:^(vlc)$"
      "opaque,class:^(celluloid)$"
      "opaque,class:^(obs)$"
      "opaque,class:^(kdenlive)$"
      "opaque,title:^(Picture-in-Picture)$"
      "opaque,title:^(Media viewer)$"

      # Gaming applications
      "opaque,class:^(steam)$"
      "opaque,class:^(lutris)$"
      "opaque,class:^(minecraft)$"
      "opaque,class:^(gamemode)$"

      # Fullscreen applications should be opaque
      "opaque,fullscreen:1"

      # Special transparency for terminal applications
      "opacity 0.80 0.70,class:^(kitty)$"
      "opacity 0.80 0.70,class:^(ghostty)$"
      "opacity 0.80 0.70,class:^(alacritty)$"
      "opacity 0.80 0.70,class:^(foot)$"

      # File managers with slight transparency
      "opacity 0.90 0.80,class:^(thunar)$"
      "opacity 0.90 0.80,class:^(nautilus)$"
      "opacity 0.90 0.80,class:^(dolphin)$"

      # Text editors and IDEs with slight transparency
      "opacity 0.90 0.85,class:^(code)$"
      "opacity 0.90 0.85,class:^(codium)$"
      "opacity 0.90 0.85,class:^(zed)$"
      "opacity 0.90 0.85,class:^(neovide)$"

      # System applications
      "opacity 0.90 0.80,class:^(gnome-calculator)$"
      "opacity 0.90 0.80,class:^(org.gnome.Calculator)$"
      "opacity 0.95 0.85,title:^(Volume Control)$"

      # Floating windows get extra transparency
      "opacity 0.80 0.70,floating:1"
    ];

    # Layer rules for UI elements (waybar, notifications, etc.)
    layerrule = [
      # Waybar transparency and blur
      "blur,waybar"
      "ignorezero,waybar"
      "ignorealpha 0.2,waybar"

      # Notification transparency
      "blur,notifications"
      "ignorezero,notifications"
      "ignorealpha 0.2,notifications"

      # Application launcher
      "blur,launcher"
      "ignorezero,launcher"
      "blur,rofi"
      "ignorezero,rofi"

      # Lock screen effects
      "blur,lockscreen"
      "ignorezero,lockscreen"

      # Logout dialog
      "blur,logout_dialog"
      "ignorezero,logout_dialog"

      # Overview/workspace switcher
      "blur,overview"
      "ignorezero,overview"

      # Screenshot UI
      "blur,screenshot"
      "ignorezero,screenshot"
    ];

    # Animation settings optimized for transparency
    animations = {
      enabled = true;
      bezier = [
        "wind,0.05,0.9,0.1,1.05"
        "winIn,0.1,1.1,0.1,1.1"
        "winOut,0.3,-0.3,0,1"
        "liner,1,1,1,1"
      ];
      animation = [
        "windows,1,6,wind,slide"
        "windowsIn,1,6,winIn,slide"
        "windowsOut,1,5,winOut,slide"
        "windowsMove,1,5,wind,slide"
        "border,1,1,liner"
        "borderangle,1,30,liner,loop"
        "fade,1,10,default"
        "workspaces,1,5,wind"
      ];
    };

    # Environment variables for better transparency support
    env = [
      "WLR_NO_HARDWARE_CURSORS,1"  # Fix cursor issues with transparency
      "NIXOS_OZONE_WL,1"           # Better Wayland support for browsers
    ];
  };
}
