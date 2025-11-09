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
    lxappearance
    dconf-editor
  ];

  # Common theme environment variables
  home.sessionVariables = {
    # Cursor theme (shared between GTK and Qt)
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";

    # Backend preferences
    GDK_BACKEND = "wayland,x11,*";
  };

  # XDG settings for consistent theming
  xdg.configFile."fontconfig/fonts.conf" = {
    text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias>
          <family>monospace</family>
          <prefer>
            <family>JetBrainsMono Nerd Font</family>
            <family>Noto Sans Mono</family>
          </prefer>
        </alias>
        <alias>
          <family>sans-serif</family>
          <prefer>
            <family>Noto Sans</family>
          </prefer>
        </alias>
        <alias>
          <family>serif</family>
          <prefer>
            <family>Noto Serif</family>
          </prefer>
        </alias>
      </fontconfig>
    '';
  };
}
