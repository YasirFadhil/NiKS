{ pkgs, config, ... }:

{
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/yasirfadhil/Pictures/Fuji.jpg
    wallpaper = HDMI-A-1,/home/yasirfadhil/Pictures/Fuji.jpg
    wallpaper = eDP-1,/home/yasirfadhil/Pictures/Fuji.jpg
  '';
}
