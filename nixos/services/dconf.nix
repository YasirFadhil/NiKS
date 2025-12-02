{ config, pkgs, ... }:

{
  # Enable dconf for GNOME-based applications
  programs.dconf.enable = true;

  # Dconf packages
  environment.systemPackages = with pkgs; [
    dconf
    dconf-editor
    gsettings-desktop-schemas
    glib # Includes gsettings
  ];

  # Enable dconf service
  services.dbus.packages = [ pkgs.dconf ];

  # Ensure proper XDG environment for GTK apps
  environment.variables = {
    # Force GTK apps to use the portal for file dialogs
    GTK_USE_PORTAL = "1";
    # Ensure gsettings schema path is available
    XDG_DATA_DIRS = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS";
  };

  # Enable required services for proper theme application
  services.dbus.enable = true;
  services.gvfs.enable = true;
}
