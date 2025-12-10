{ pkgs, lib, config, ... }:

{
  # Qt Configuration - Use qt5ct/qt6ct for theme management
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  # Note: Qt-related session environment variables were intentionally removed
  # from this theme file. They are now defined centrally in `home.nix` so
  # that session variables are applied consistently for the whole user profile.

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
