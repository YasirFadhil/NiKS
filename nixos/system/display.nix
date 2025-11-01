{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;

  # Use ly display manager
  services.displayManager.ly = {
    enable = true;
  };

  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Additional GNOME optimization (optional)
  environment.gnome.excludePackages = with pkgs; [
    # Remove if you want to keep these
    gnome-tour
    epiphany
    geary
    evince
  ];
  services.gvfs.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
    model = "chromebook";
  };

  # Portal configuration for Wayland
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
    wlr.enable = true;
  };
}
