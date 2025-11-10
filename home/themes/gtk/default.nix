{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    # GTK Themes
    whitesur-gtk-theme
    fluent-gtk-theme
    catppuccin-gtk
    layan-gtk-theme
    adw-gtk3

    # Icon Themes
    whitesur-icon-theme
    papirus-icon-theme

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
    GTK_THEME = "Fluent-Dark";
    GTK_APPLICATION_PREFER_DARK_THEME = "1";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Fluent-Dark";
      package = pkgs.fluent-gtk-theme;
    };
    font = {
      name = "Noto Sans Medium";
      size = 11;
    };
    iconTheme = {
      name = "WhiteSur";
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
    gtk-icon-theme-name=WhiteSur
    gtk-theme-name=Fluent-Dark
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=20
    gtk-font-name=Noto Sans Medium 11
  '';

  # GTK2 configuration (uses different format)
  xdg.configFile."gtk-2.0/gtkrc".text = ''
    gtk-theme-name="Fluent-Dark"
    gtk-icon-theme-name="WhiteSur"
    gtk-font-name="Noto Sans Medium 11"
    gtk-cursor-theme-name="Bibata-Modern-Ice"
    gtk-cursor-theme-size=20
  '';
}
