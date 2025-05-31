{ config, pkgs, ... }:


let
  brightnessPkgs = import ../system/brightness { pkgs = pkgs; };
  volumePkgs = import ../system/volume { pkgs = pkgs; };
  hyprlockConfig = import ./hypr/hyprlock.nix { inherit pkgs; };
  hyprIdleConfig = import ./hypr/hypridle.nix { inherit pkgs; };
in
{
  imports = [
    ./hypr/hyprland.nix
    ./nushell
    ./fastfetch
    ./fastfetch/def-comp.nix
    ./hypr/polkitagent.nix
    hyprlockConfig
    hyprIdleConfig
  ];

  home.username = "yasirfadhil";
  home.homeDirectory = "/home/yasirfadhil";

  programs.home-manager.enable = true;
  home.packages = import ./packages.nix {inherit pkgs;};

  #programs.gnome-keyring.enable = true;
  programs.nushell.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.firefox.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      size = 20;
    };
  };

  home.sessionVariables = {
    PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$PATH";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  fonts.fontconfig.enable = true;
  home.stateVersion = "24.05";
}
