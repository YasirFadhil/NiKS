{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpaper
  ];

  # Optional: Example configuration for hyprpaper
  # You can put this in your home directory as ~/.config/hypr/hyprpaper.conf
  # Or manage it with home-manager if desired.
  # Example content:
  #
  # {
  #   home.file.".config/hypr/hyprpaper.conf".text = ''
  #     preload = /path/to/wallpaper1.jpg
  #     wallpaper = HDMI-A-1,/path/to/wallpaper1.jpg
  #     wallpaper = DP-1,/path/to/wallpaper2.jpg
  #   '';
  # }
}
