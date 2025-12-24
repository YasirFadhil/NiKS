{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    # System home
    ./systems/niri
    # ./systems/hypr
    ./systems/hypr/hypridle.nix
    ./systems/hypr/hyprlock.nix
    ./systems/waybar
    ./systems/swaync
    ./systems/nwg-dock
    # ./systems/hyprpanel
    ./systems/noctalia
    ./systems/services/battery-monitor.nix
    # ./systems/dms

    #Programs home
    ./programs/spicetify
    ./programs/polkitagent
    ./programs/nus
    ./programs/kitty
    ./programs/ghostty
    ./programs/foot
    ./programs/fastfetch
    ./programs/zenn
    ./programs/zed
    ./programs/rofi-launch
    ./programs/nvchad
    # ./programs/ulauncher

    # Others
    ./themes
    ./var.nix
    ./nh.nix
  ];

  home.username = "yasirfadhil";
  home.homeDirectory = "/home/yasirfadhil";
  programs.home-manager.enable = true;
  home.packages = import ./package.nix {inherit pkgs;};
  waybar.enable = true;
  programs.zsh.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user.name = "YasirFadhil";
      user.email = "yasirfadhil46@gmail.com";
    };
  };

  xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
  };

  home.sessionVariables = {
     # PATH configuration
     PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$PATH";

     # Wayland support for applications
     NIXOS_OZONE_WL = "1";
     MOZ_ENABLE_WAYLAND = "1";

     # SSH and Authentication
     SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";

     # Session type (static for all Wayland sessions)
     XDG_SESSION_TYPE = "wayland";

     # GTK environment variables (merged from themes/gtk)
     GTK2_RC_FILES = "${config.home.homeDirectory}/.gtkrc-2.0";
     GTK_THEME = "WhiteSur-Dark";
     GTK_APPLICATION_PREFER_DARK_THEME = "1";
     GTK_USE_PORTAL = "1";
     GTK_DEBUG = "";

     # Qt environment variables (merged from themes/qt)
     QT_QPA_PLATFORMTHEME = "qt5ct";
     QT_QPA_PLATFORM = "xcb;wayland";
     QT_AUTO_SCREEN_SCALE_FACTOR = "1";
     QT_SCALE_FACTOR = "1";
     QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

     # XWayland display for X11 applications
     DISPLAY = ":0";
  };

  home.stateVersion = "24.05";
}
