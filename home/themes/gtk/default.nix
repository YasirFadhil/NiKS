{ pkgs, lib, config, inputs, ... }:

{
  # GTK theme configuration
  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    font = {
      name = "SF Pro Display";
      size = 11;
    };
    iconTheme = {
      name = "MacTahoe-dark";
      package = null;
      # name = "WhiteSur-dark";
      # package = pkgs.whitesur-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 20;
    };
  };

  # Additional GTK environment variables for better compatibility
  home.sessionVariables = {
    GTK2_RC_FILES = "${config.home.homeDirectory}/.gtkrc-2.0";
    GTK_THEME = "WhiteSur-Dark";
    GTK_APPLICATION_PREFER_DARK_THEME = "1";
  };

  # GTK3 configuration
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=MacTahoe-dark
    gtk-theme-name=WhiteSur-Dark
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=20
    gtk-font-name=SF Pro Display 11
    gtk-application-prefer-dark-theme=1
    gtk-primary-button-warps-slider=false
    gtk-decoration-layout=appmenu:close
  '';

  # GTK4 configuration
  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=MacTahoe-dark
    gtk-theme-name=WhiteSur-Dark
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=20
    gtk-font-name=SF Pro Display 11
    gtk-application-prefer-dark-theme=1
    gtk-primary-button-warps-slider=false
    gtk-decoration-layout=appmenu:close
  '';

  # GTK2 configuration is handled automatically by home manager's gtk module

  # GNOME/dconf settings for dark theme
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "WhiteSur-Dark";
      icon-theme = "MacTahoe-dark";
      cursor-theme = "Bibata-Modern-Ice";
      cursor-size = 20;
      font-name = "SF Pro Display 11";
      document-font-name = "SF Pro Display 11";
      monospace-font-name = "SF Mono 11";
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:close";
      titlebar-font = "SF Pro Display Bold 11";
    };
  };
}
