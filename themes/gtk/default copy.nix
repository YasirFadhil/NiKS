{ config, pkgs, lib, ... }:

let
  themerepo = {
    gtk = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "WhiteSur-gtk-theme";
      rev = "master";
      sha256 = "tuon9XxMdrz9XNTp50sbss2gtx6H9hEZh8t2jSoqx28=";
    };
    icon = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "WhiteSur-icon-theme";
      rev = "master";
      sha256 = "AIcwCXmNm3VA9GUNMsHtYYHNN3uuP8tmj/ivSdvjBy4=";
    };
    # cursor = pkgs.fetchFromGitHub {
    #   owner = "ful1e5";
    #   repo = "Bibata_Cursor";
    #   rev = "master";
    #   sha256 = "kIKidw1vditpuxO1gVuZeUPdWBzkiksO/q2R/+DUdEc=";
    # };
  };
in
{
  options.theming = {
    enable = lib.mkEnableOption "Enable theming (GTK, icon, cursor)";
  };

  config = lib.mkIf config.theming.enable {
    # Pastikan struktur folder langsung (tidak nested)
    home.file.".themes/WhiteSur".source = "${themerepo.gtk}/WhiteSur";
    home.file.".icons/WhiteSur".source = "${themerepo.icon}/WhiteSur";
    # home.file.".icons/Bibata-Modern-Ice".source = "${themerepo.cursor}/Bibata-Modern-Ice";

    # GTK config
    gtk = {
      enable = true;
      theme.name = "WhiteSur";
      iconTheme.name = "WhiteSur";
      cursorTheme.name = "Bibata-Modern-Ice";
    };

    # File settings GTK3
    xdg.configFile."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=WhiteSur
      gtk-icon-theme-name=WhiteSur
      gtk-cursor-theme-name=Bibata-Modern-Ice
      gtk-font-name=Sans 10
    '';

    # Agar cursor work di Wayland/Hyprland juga
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Ice";
      size = 20;
      package = pkgs.bibata-cursors; # karena sudah manual
    };

    # Tambahan: environment variable agar lebih pasti
    home.sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "20";
      GTK_THEME = "WhiteSur";
      GTK_ICON_THEME = "WhiteSur";
    };
  };
}
