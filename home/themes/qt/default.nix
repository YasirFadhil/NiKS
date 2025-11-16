{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    # Qt5 and Qt6 theme tools
    libsForQt5.qt5ct
    qt6Packages.qt6ct

    # Qt style plugins
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins
    libsForQt5.qtquickcontrols2
    libsForQt5.qtgraphicaleffects

    # Qt Wayland Support
    qt5.qtwayland
    qt6.qtwayland

    # KDE/Breeze Themes
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.breeze-gtk

    # Kvantum themes
    libsForQt5.qtstyleplugin-kvantum
    whitesur-gtk-theme

    # Additional Qt Libraries
    libsForQt5.qtbase
  ];

  # Qt Configuration - Use qt5ct/qt6ct for theme management
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  # Qt Environment Variables
  home.sessionVariables = {
    # Use qt5ct/qt6ct as platform theme
    QT_QPA_PLATFORMTHEME = "qt5ct";

    # Qt Platform - prioritize XCB for OnlyOffice compatibility, fallback to Wayland
    QT_QPA_PLATFORM = "xcb;wayland";

    # Qt Scaling and Display Settings
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # XWayland Display for X11 applications
    DISPLAY = ":0";
  };

  # Qt5ct configuration with WhiteSur Dark theme
  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [General]
    style=kvantum
    palette=@Variant(\0\0\0\x80\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)
    font="Noto Sans,11,-1,5,50,0,0,0,0,0"
    [Appearance]
    custom_palette=false
    icon_theme=WhiteSur-dark
    standard_dialogs=default
    button_box_layout=0
  '';

  # Qt6ct configuration with WhiteSur Dark theme
  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [General]
    style=kvantum
    font="Noto Sans,11,-1,5,50,0,0,0,0,0"
    [Appearance]
    icon_theme=WhiteSur-dark
    standard_dialogs=default
    button_box_layout=0
  '';

  # Kvantum theme configuration - WhiteSur Dark
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=WhiteSur-Dark
  '';
}
