{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    # System home
    ./systems/niri
    ./systems/hypr/hyprland.nix
    ./systems/hypr/hyprpaper.nix
    ./systems/waybar
    ./systems/swaync
    ./systems/nwg-dock
    # ./systems/hyprpanel

    #Programs home
    ./programs/spicetify
    ./programs/swaylock
    ./programs/polkitagent
    ./programs/nus
    ./programs/kitty
    ./programs/ghostty
    ./programs/fastfetch
    ./programs/fastfetch/def-comp.nix
    ./programs/zenn
    ./programs/zed
    ./programs/rofi-launch
    #./programs/anyrun

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
  };

  fonts.fontconfig.enable = true;
  home.stateVersion = "24.05";
}
