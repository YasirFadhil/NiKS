{ pkgs, lib, config, ... }:

{
  # Collection of GTK themes that support transparency and blur effects

  home.packages = with pkgs; [
    # Transparent-friendly themes
    orchis-theme
    arc-theme
    numix-gtk-theme
    adapta-gtk-theme
    materia-theme
    yaru-theme

    # Glass/blur effect themes
    skeuos-gtk
    flat-remix-gtk

    # Theme tools
    gradience  # For creating custom themes
    gtk-engine-murrine
    gtk-engines
  ];

  # Custom transparent GTK theme configurations
  programs.dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Orchis-Dark";
      icon-theme = "WhiteSur";
      cursor-theme = "Bibata-Modern-Ice";
      font-name = "Noto Sans 11";
      color-scheme = "prefer-dark";
    };

    # Enable transparency in GTK apps
    "org/gnome/desktop/wm/preferences" = {
      theme = "Orchis-Dark";
      titlebar-uses-system-font = true;
    };
  };

  # Custom gtkrc for enhanced transparency
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
    gtk-theme-name=Orchis-Dark
    gtk-icon-theme-name=WhiteSur
    gtk-font-name=Noto Sans 11
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=20
    gtk-toolbar-style=GTK_TOOLBAR_BOTH
    gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
    gtk-button-images=1
    gtk-menu-images=1
    gtk-enable-event-sounds=1
    gtk-enable-input-feedback-sounds=1
    gtk-xft-antialias=1
    gtk-xft-hinting=1
    gtk-xft-hintstyle=hintfull
    gtk-xft-rgba=rgb
    gtk-decoration-layout=close,minimize,maximize:
  '';

  # Enhanced GTK2 configuration with transparency support
  xdg.configFile."gtk-2.0/gtkrc".text = ''
    # GTK2 Theme Configuration with Transparency Support

    gtk-theme-name="Orchis-Dark"
    gtk-icon-theme-name="WhiteSur"
    gtk-font-name="Noto Sans 11"
    gtk-cursor-theme-name="Bibata-Modern-Ice"
    gtk-cursor-theme-size=20

    # Enable transparency and visual effects
    gtk-enable-animations=1
    gtk-primary-button-warps-slider=1
    gtk-toolbar-style=GTK_TOOLBAR_BOTH
    gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
    gtk-button-images=1
    gtk-menu-images=1

    # Font rendering
    gtk-xft-antialias=1
    gtk-xft-hinting=1
    gtk-xft-hintstyle="hintslight"
    gtk-xft-rgba="rgb"

    # Custom widget styling for transparency
    style "transparent-bg" {
      bg[NORMAL] = shade(0.8, "#2e3440")
      bg[PRELIGHT] = shade(0.9, "#3b4252")
      bg[ACTIVE] = shade(0.7, "#434c5e")
      bg[SELECTED] = shade(0.8, "#88c0d0")
      bg[INSENSITIVE] = shade(0.6, "#4c566a")

      base[NORMAL] = shade(0.8, "#2e3440")
      base[PRELIGHT] = shade(0.9, "#3b4252")
      base[ACTIVE] = shade(0.7, "#434c5e")
      base[SELECTED] = shade(0.8, "#88c0d0")
      base[INSENSITIVE] = shade(0.6, "#4c566a")

      text[NORMAL] = "#eceff4"
      text[PRELIGHT] = "#eceff4"
      text[ACTIVE] = "#eceff4"
      text[SELECTED] = "#2e3440"
      text[INSENSITIVE] = "#616e88"
    }

    style "transparent-menubar" = "transparent-bg" {
      bg[NORMAL] = shade(0.7, "#2e3440")
    }

    style "transparent-menu" = "transparent-bg" {
      bg[NORMAL] = shade(0.85, "#3b4252")
    }

    style "transparent-toolbar" = "transparent-bg" {
      bg[NORMAL] = shade(0.75, "#2e3440")
    }

    # Apply transparent styles
    widget_class "*MenuBar*" style "transparent-menubar"
    widget_class "*Menu*" style "transparent-menu"
    widget_class "*Toolbar*" style "transparent-toolbar"
    widget_class "*" style "transparent-bg"
  '';

  # Gradience configuration for custom theme generation
  xdg.configFile."gradience/presets/BlurTheme.json".text = builtins.toJSON {
    name = "BlurTheme";
    variables = {
      accent_color = "#88c0d0";
      accent_bg_color = "#5e81ac";
      accent_fg_color = "#ffffff";
      destructive_color = "#bf616a";
      destructive_bg_color = "#bf616a";
      destructive_fg_color = "#ffffff";
      success_color = "#a3be8c";
      success_bg_color = "#a3be8c";
      success_fg_color = "#ffffff";
      warning_color = "#ebcb8b";
      warning_bg_color = "#ebcb8b";
      warning_fg_color = "#000000";
      error_color = "#bf616a";
      error_bg_color = "#bf616a";
      error_fg_color = "#ffffff";
      window_bg_color = "rgba(46, 52, 64, 0.8)";
      window_fg_color = "#eceff4";
      view_bg_color = "rgba(59, 66, 82, 0.8)";
      view_fg_color = "#eceff4";
      headerbar_bg_color = "rgba(46, 52, 64, 0.9)";
      headerbar_fg_color = "#eceff4";
      headerbar_border_color = "#434c5e";
      headerbar_backdrop_color = "rgba(46, 52, 64, 0.7)";
      headerbar_shade_color = "rgba(0, 0, 0, 0.36)";
      card_bg_color = "rgba(67, 76, 94, 0.8)";
      card_fg_color = "#eceff4";
      card_shade_color = "rgba(0, 0, 0, 0.36)";
      dialog_bg_color = "rgba(46, 52, 64, 0.9)";
      dialog_fg_color = "#eceff4";
      popover_bg_color = "rgba(59, 66, 82, 0.9)";
      popover_fg_color = "#eceff4";
      shade_color = "rgba(0, 0, 0, 0.36)";
      scrollbar_outline_color = "rgba(0, 0, 0, 0.5)";
    };
    palette = {
      blue_ = ["#99c1f1" "#62a0ea" "#3584e4" "#1c71d8" "#1a5fb4"];
      green_ = ["#8ff0a4" "#57e389" "#33d17a" "#2ec27e" "#26a269"];
      yellow_ = ["#f9f06b" "#f8e45c" "#f6d32d" "#f5c211" "#e5a50a"];
      orange_ = ["#ffbe6f" "#ffa348" "#ff7800" "#e66100" "#c64600"];
      red_ = ["#f66151" "#ed333b" "#e01b24" "#c01c28" "#a51d2d"];
      purple_ = ["#dc8add" "#c061cb" "#9141ac" "#813d9c" "#613583"];
      brown_ = ["#cdab8f" "#b5835a" "#986a44" "#865e3c" "#63452c"];
      light_ = ["#ffffff" "#f6f5f4" "#deddda" "#c0bfbc" "#9a9996"];
      dark_ = ["#77767b" "#5e5c64" "#3d3846" "#241f31" "#000000"];
    };
  };

  # Environment variables for better transparency support
  home.sessionVariables = {
    # Force GTK to use transparency
    GTK_USE_PORTAL = "1";

    # Better font rendering with transparency
    FREETYPE_PROPERTIES = "truetype:interpreter-version=40";

    # Enable GTK animations and transitions
    GTK_OVERLAY_SCROLLING = "1";
  };

  # Additional theme utilities
  programs.dconf.enable = true;

  # Theme switching script
  home.packages = with pkgs; [
    (writeShellScriptBin "switch-gtk-theme" ''
      #!/usr/bin/env bash

      case "$1" in
        "orchis")
          gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Dark"
          echo "Switched to Orchis Dark theme"
          ;;
        "arc")
          gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"
          echo "Switched to Arc Dark theme"
          ;;
        "materia")
          gsettings set org.gnome.desktop.interface gtk-theme "Materia-dark"
          echo "Switched to Materia Dark theme"
          ;;
        "adapta")
          gsettings set org.gnome.desktop.interface gtk-theme "Adapta-Nokto"
          echo "Switched to Adapta Nokto theme"
          ;;
        "numix")
          gsettings set org.gnome.desktop.interface gtk-theme "Numix-DarkBlue"
          echo "Switched to Numix Dark Blue theme"
          ;;
        *)
          echo "Usage: switch-gtk-theme [orchis|arc|materia|adapta|numix]"
          echo "Current theme: $(gsettings get org.gnome.desktop.interface gtk-theme)"
          ;;
      esac

      # Reload GTK applications
      killall -HUP gtk-update-icon-cache 2>/dev/null || true
      notify-send "Theme Changed" "GTK theme has been updated" -i preferences-desktop-theme
    '')
  ];
}
