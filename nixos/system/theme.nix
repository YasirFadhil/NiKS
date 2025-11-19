{ pkgs, ... }:

{
  # Minimal system-level theme configuration
  # Most theming is handled by home-manager in /etc/nixos/home/themes/

  # Only provide essential theme packages at system level
  environment.systemPackages = with pkgs; [
    # Theme packages
    whitesur-gtk-theme
    whitesur-icon-theme
    # Qt configuration tools
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    # Cursor theme
    bibata-cursors
    # GNOME dependencies
    gsettings-desktop-schemas
  ];

  # GSettings schemas path for GNOME
  environment.pathsToLink = [ "/share/gsettings-schemas" ];

  # Ensure dconf is available for GNOME settings
  programs.dconf.enable = true;
}
