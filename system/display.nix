{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  services.desktopManager.gnome.enable = true;
  #services.desktopManager.plasma6.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    model = "chromebook";
  };
}
