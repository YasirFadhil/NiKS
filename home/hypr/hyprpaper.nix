{ pkgs, ... }:

{
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ../../themes/pict/Fuji.jpg
    wallpaper = HDMI-A-1,../../themes/pict/Fuji.jpg
    wallpaper = DP-1,../../themes/pict/Fuji.jpg
  '';
}
