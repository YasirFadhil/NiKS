{ config, pkgs, lib, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      # Display
      show-failed-attempts = true;
      show-keyboard-layout = true;

      # Colors
      color = "1e1e2e";

      # Inside colors (the input circle)
      inside-color = "313244";
      inside-clear-color = "313244";
      inside-caps-lock-color = "313244";
      inside-ver-color = "89b4fa";
      inside-wrong-color = "f38ba8";

      # Ring colors (outer circle)
      ring-color = "45475a";
      ring-clear-color = "45475a";
      ring-caps-lock-color = "f9e2af";
      ring-ver-color = "89b4fa";
      ring-wrong-color = "f38ba8";

      # Key highlight colors
      key-hl-color = "cba6f7";

      # Line colors (separator)
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      # Text colors
      text-color = "cdd6f4";
      text-clear-color = "cdd6f4";
      text-caps-lock-color = "f9e2af";
      text-ver-color = "89b4fa";
      text-wrong-color = "f38ba8";

      # Separator colors
      separator-color = "00000000";

      # Layout
      font = "JetBrainsMono Nerd Font";
      font-size = 24;

      # Input field
      indicator-radius = 100;
      indicator-thickness = 7;

      # Effects
      screenshots = true;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      clock = true;

      # Timeouts
      fade-in = 0.2;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;

      # Text strings
      text-caps-lock-color = "f9e2af";
      caps-lock-key-hl-color = "f9e2af";
      caps-lock-bs-hl-color = "f9e2af";

      # Additional styling
      datestr = "%A, %B %e";
      timestr = "%H:%M";
    };
  };

  # Add swaylock to system packages for manual usage
  home.packages = with pkgs; [
    swaylock-effects
  ];
}
