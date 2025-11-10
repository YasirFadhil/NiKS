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

  # Use ly display manager
  services.displayManager.ly = {
    enable = true;
  };

  # Enable XWayland for X11 app compatibility
  programs.xwayland.enable = true;

  # Add niri-session to available sessions
  services.displayManager.sessionPackages = [ niri-session-package ];

  # Environment variables for Wayland sessions
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    # Qt platform configuration - try xcb first for OnlyOffice compatibility
    QT_QPA_PLATFORM = "xcb;wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";
  };

  # Ensure systemd user services start properly
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.systemd}/bin/systemctl --user import-environment PATH DISPLAY WAYLAND_DISPLAY
    ${pkgs.systemd}/bin/systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP
    ${pkgs.systemd}/bin/systemctl --user import-environment NIXOS_OZONE_WL MOZ_ENABLE_WAYLAND QT_QPA_PLATFORM
    ${pkgs.systemd}/bin/systemctl --user start graphical-session.target
  '';

  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.niri.enable = true;
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
  security.pam.services.ly.enableGnomeKeyring = true;
  security.pam.services.ly.startSession = true;

  # Enable user lingering for systemd services
  systemd.services."user@".enable = true;
}
