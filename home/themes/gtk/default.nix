{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    # GTK Themes
    whitesur-gtk-theme
    adw-gtk3

    # Icon Themes
    whitesur-icon-theme

    # Cursor Themes
    bibata-cursors

    # GNOME theming tools
    gnome-tweaks
    gnome-extension-manager

    # System libraries for GTK
    libcanberra-gtk3
  ];

  # GTK Environment Variables
  home.sessionVariables = {
    GTK2_RC_FILES = "${config.home.homeDirectory}/.gtkrc-2.0";
    GTK_THEME = "WhiteSur-Dark";
    GTK_APPLICATION_PREFER_DARK_THEME = "1";
  };

  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    font = {
      name = "Noto Sans";
      size = 11;
    };
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 20;
    };
  };

  # GTK4 configuration
  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=WhiteSur-dark
    gtk-theme-name=WhiteSur-Dark
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=20
    gtk-font-name=Noto Sans 11
    gtk-application-prefer-dark-theme=1
  '';

  # GTK2 configuration (uses different format)
  xdg.configFile."gtk-2.0/gtkrc".text = ''
    gtk-theme-name="WhiteSur-Dark"
    gtk-icon-theme-name="WhiteSur-dark"
    gtk-font-name="Noto Sans 11"
    gtk-cursor-theme-name="Bibata-Modern-Ice"
    gtk-cursor-theme-size=20
  '';

  # GNOME/dconf settings for dark theme
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "WhiteSur-Dark";
      icon-theme = "WhiteSur-dark";
      cursor-theme = "Bibata-Modern-Ice";
      cursor-size = 20;
      font-name = "Noto Sans 11";
      document-font-name = "Noto Sans 11";
      monospace-font-name = "JetBrains Mono 11";
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:close";
      titlebar-font = "Noto Sans Bold 11";
    };
  };
}
