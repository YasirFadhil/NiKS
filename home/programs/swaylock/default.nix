{ config, pkgs, lib, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      # Display
      show-failed-attempts = true;
      show-keyboard-layout = false;

      # Background
      image = "/etc/nixos/home/themes/wallpaper/background_moon.jpg";
      scaling = "fill";

      # Colors - matching hyprlock's white/transparent theme
      color = "00000000";  # Transparent background

      # Inside colors (the input circle) - semi-transparent like hyprlock
      inside-color = "33333312";  # rgba(51,51,51,0.07) equivalent
      inside-clear-color = "33333312";
      inside-caps-lock-color = "33333312";
      inside-ver-color = "ffffff55";  # White with transparency for verification
      inside-wrong-color = "ff000055";  # Red with transparency for wrong

      # Ring colors (outer circle) - matching hyprlock entry border
      ring-color = "3b3b3b55";  # rgba(59,59,59,0.33) equivalent
      ring-clear-color = "3b3b3b55";
      ring-caps-lock-color = "3b3b3b55";
      ring-ver-color = "ffffff88";
      ring-wrong-color = "ff0000aa";

      # Key highlight colors - white theme
      key-hl-color = "ffffffaa";

      # Line colors (separator) - transparent
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      # Text colors - white like hyprlock
      text-color = "ffffffff";  # rgba(255,255,255,1)
      text-clear-color = "ffffffff";
      text-caps-lock-color = "ffffffff";
      text-ver-color = "ffffffff";
      text-wrong-color = "ff0000ff";

      # Separator colors
      separator-color = "00000000";

      # Layout - matching hyprlock fonts
      font = "Rubik Light";
      font-size = 16;

      # Input field - similar to hyprlock dimensions
      indicator-radius = 125;  # Adjusted for 250x40 equivalent
      indicator-thickness = 2;  # Match hyprlock outline_thickness

      # Effects - minimal blur like hyprlock background
      screenshots = false;  # Use image instead
      effect-blur = "3x2";  # Lighter blur
      effect-vignette = "0.3:0.3";  # Subtle vignette

      # Clock and date - matching hyprlock style
      clock = true;
      timestr = "%I:%M";  # 12-hour format like hyprlock
      datestr = "%A, %d %B";  # Match hyprlock date format
      clock-font-size = 90;  # Large clock like hyprlock

      # Positioning adjustments
      indicator-x-position = 0;
      indicator-y-position = -100;  # Move up like hyprlock input field

      # Timeouts - match hyprlock grace period
      fade-in = 0.3;
      grace = 0;  # Match hyprlock grace = 0
      grace-no-mouse = false;
      grace-no-touch = false;

      # Additional styling to match hyprlock
      caps-lock-key-hl-color = "ffffffff";
      caps-lock-bs-hl-color = "ffffffff";

      # Disable some elements for cleaner look
      layout-font-size = 0;  # Hide keyboard layout
      layout-text-color = "00000000";
    };
  };

  # Add swaylock to system packages for manual usage
  home.packages = with pkgs; [
    swaylock-effects
  ];
}
