{ config, pkgs, ... }:

{
  # Enable dconf for GNOME-based applications
  programs.dconf.enable = true;

  # Dconf packages
  environment.systemPackages = with pkgs; [
    dconf
    dconf-editor
  ];

  # Enable dconf service
  services.dbus.packages = [ pkgs.dconf ];
}
