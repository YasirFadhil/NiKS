{ pkgs, lib, ... }:

pkgs.makeDesktopItem {
  name = "niri-session";
  desktopName = "Niri (Session)";
  comment = "A scrollable-tiling Wayland compositor with niri-session wrapper";
  exec = "niri-session";
  icon = "niri";
  type = "Application";
  categories = [ "System" ];
  noDisplay = false;
  extraConfig = {
    DesktopNames = "niri";
    Keywords = "wayland;wm;tiling";
  };
}
