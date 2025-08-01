{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./var.nix
    ./nh.nix
    ./spicetify
    ./hypr/hyprland.nix
    ./hyprpanel
    # ./waybar
    ./nus
    ./kitty
    ./fastfetch
    ./fastfetch/def-comp.nix
    ./hypr/polkitagent.nix
    ./zenn
    ../themes/gtk
    ../themes/qt
    # ../themes/font
    ./nwg-dock/default.nix
    ./scripts/rasi.nix
    ./scripts/rasi2.nix
  ];

  home.username = "yasirfadhil";
  home.homeDirectory = "/home/yasirfadhil";

  programs.home-manager.enable = true;
  home.packages = import ./package.nix {inherit pkgs;};
  # waybar.enable = true;
  # swaync.enable = true;
  # theming.enable = true;
  programs.zsh.enable = true;
  programs.git = {
    enable = true;
    userName = "YasirFadhil";
    userEmail = "yasirfadhil46@gmail.com";
  };

  xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # Penting untuk aplikasi GTK
  };



  home.sessionVariables = {
    PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$PATH";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
    QT6CT_PLATFORMTHEME = lib.mkForce "qt6ct";
    GTK2_RC_FILES = "${config.home.homeDirectory}/.gtkrc-2.0";
    GTK_THEME = "Fluent-Dark";
    GTK_APPLICATION_PREFER_DARK_THEME = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "GNOME:Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  fonts.fontconfig.enable = true;
  home.stateVersion = "24.05";
}
