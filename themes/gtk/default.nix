{ pkgs, lib, config, ... }:

{

  home.packages = with pkgs; [
    whitesur-gtk-theme
    bibata-cursors
    whitesur-icon-theme
    catppuccin-gtk
    lxappearance
    layan-gtk-theme
    libsForQt5.qtstyleplugin-kvantum
    fluent-gtk-theme
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Fluent-Dark";
      package = pkgs.fluent-gtk-theme;
    };
    # font = {
    #   name = "Fira Code Nerd Font";
    #   size = 10;
    # };
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

  # Jika ingin theme diterapkan juga untuk GTK4:
  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=WhiteSur
    gtk-theme-name=Fluent-Dark
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=20
  '';
}
