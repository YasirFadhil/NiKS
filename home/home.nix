{ config, pkgs, inputs, lib, ... }:


let
  hyprlockConfig = import ./hypr/hyprlock.nix { inherit pkgs; };
  hyprIdleConfig = import ./hypr/hypridle.nix { inherit pkgs; };
in
{
  imports = [
     inputs.spicetify-nix.homeManagerModules.default
    # inputs.stylix.homeModules.stylix
    # ../themes/stylix/nixy.nix
    ./var.nix
    ./spicetify
    ./hypr/hyprland.nix
    ./hyprpanel/default.nix
    ./nus
    ./fastfetch
    ./fastfetch/def-comp.nix
    ./hypr/polkitagent.nix
    ./zenn
    ./nwg-dock
    hyprlockConfig
    hyprIdleConfig
  ];

  home.username = "yasirfadhil";
  home.homeDirectory = "/home/yasirfadhil";

  programs.home-manager.enable = true;
  home.packages = import ./packages.nix {inherit pkgs;};

  programs.zsh.enable = true;
  programs.git.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = lib.mkForce "adw-gtk3-dark";
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
