{ pkgs, config, ... }:

{
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /etc/nixos/themes/pict/Fuji.jpg
    wallpaper = HDMI-A-1, /etc/nixos/themes/pict/Fuji.jpg
    wallpaper = eDP-1, /etc/nixos/themes/pict/Fuji.jpg
  '';
}
