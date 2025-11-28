# This is for setting display manager and desktop session
{ config, pkgs, lib, ... }:

let
  niri-session-package = pkgs.runCommand "niri-session-desktop" {} ''
    mkdir -p $out/share/wayland-sessions
    cat > $out/share/wayland-sessions/niri-session.desktop << EOF
    [Desktop Entry]
    Name=Niri (Session)
    Comment=A scrollable-tiling Wayland compositor with niri-session wrapper
    Exec=niri-session
    Type=Application
    DesktopNames=niri
    Keywords=wayland;wm;tiling
    EOF
  '' // {
    providedSessions = [ "niri-session" ];
  };
in
{
  services.xserver.enable = true;

  # Use GDM display manager
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # Add niri-session to available sessions
  services.displayManager.sessionPackages = [ niri-session-package ];

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

  # PAM configuration for swaylock
  security.pam.services.swaylock = {};

  # Enable systemd user services in PAM
  security.pam.services.gdm.enableGnomeKeyring = true;

  # Enable user lingering for systemd services
  systemd.services."user@".enable = true;

  # System-level Qt5/Qt6 configuration
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
  ];

  # Qt5/Qt6 platform theme configuration
  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  # Environment variables for Qt
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
