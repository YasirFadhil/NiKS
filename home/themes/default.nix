{ pkgs, lib, config, ... }:

{
  imports = [
    ./gtk
    ./qt
    ./font
  ];

  # Common theme-related packages
  home.packages = with pkgs; [
    # Theme utilities
    dconf-editor
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
