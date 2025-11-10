{ pkgs, lib, config, ... }:

{
  # Qt packages and themes
  home.packages = with pkgs; [
    # Qt GTK integration (removed qgnomeplatform as it's not available)

    # Qt Style Plugins and Themes
    libsForQt5.qtstyleplugins
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtquickcontrols2
    libsForQt5.qtgraphicaleffects

    # Qt Wayland Support
    qt5.qtwayland
    qt6.qtwayland

    # KDE/Breeze Themes
    kdePackages.breeze
    kdePackages.breeze-icons

    # Additional Qt Libraries

    libsForQt5.qtbase
    libsForQt5.qt5.qtx11extras
  ];

  # Qt Configuration - Follow GTK theme
  qt = {
    enable = true;
    platformTheme.name = "gtk2";
    style = {
      package = pkgs.libsForQt5.qtstyleplugins;
      name = "gtk2";
    };
  };

  # Qt Environment Variables
  home.sessionVariables = {
    # Qt Platform - prioritize XCB for OnlyOffice compatibility, fallback to Wayland
    QT_QPA_PLATFORM = "xcb;wayland";
    QT_QPA_PLATFORMTHEME = "gtk2";

    # Qt Scaling and Display Settings
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # XWayland Display for X11 applications
    DISPLAY = ":0";
  };

  # Qt will automatically follow GTK theme
  # No additional configuration needed since platformTheme is set to "gtk2"
}
