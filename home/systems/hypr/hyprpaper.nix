{ pkgs, config, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/etc/nixos/home/themes/pict/Wall2.jpg"
      ];
      wallpaper = [
        "eDP-1,/etc/nixos/home/themes/pict/Wall2.jpg"
        "HDMI-A-1,/etc/nixos/home/themes/pict/Wall2.jpg" # For multiple monitors
      ];
      # Optional: enable splash text
      # splash = true;
      # Optional: disable IPC
      # ipc = "off";
    };
  };
}
