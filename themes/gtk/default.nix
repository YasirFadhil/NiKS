{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    whitesur-gtk-theme
    bibata-cursors
    whitesur-icon-theme
    catppuccin-gtk
    lxappearance
    layan-gtk-theme
    fluent-gtk-theme
  ];

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
