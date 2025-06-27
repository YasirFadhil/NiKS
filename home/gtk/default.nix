{ pkgs, lib, config, ... }:

{

  home.packages = with pkgs; [
    whitesur-gtk-theme
    bibata-cursors
    # whitesur-icon-theme # Uncomment jika ingin pakai icon theme
  ];

  gtk = {
    enable = true;
    theme = {
      name = lib.mkForce "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    # Uncomment jika ingin icon theme
    # iconTheme = {
      # name = "Mkos-Big-Sur";
    #   package = pkgs.whitesur-icon-theme;
    # };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 20;
    };
  };

  # Jika ingin theme diterapkan juga untuk GTK4:
  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=adw-gtk3-dark
    # gtk-icon-theme-name=Mkos-Big-Sur
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=20
  '';
}
