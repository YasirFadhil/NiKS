{ pkgs, lib, config, ... }:

{
  imports = [
    ./gtk
    ./qt
    ./font
  ];

  # Common theme environment variables
  home.sessionVariables = {
    # Cursor theme (Bibata Modern Ice)
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";

    # Backend preferences
    GDK_BACKEND = "wayland,x11,*";
  };
}
