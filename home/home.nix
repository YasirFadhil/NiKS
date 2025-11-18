{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./var.nix
    ./nh.nix
    ./programs/spicetify
    ./programs/swaylock
    ./systems/niri
    ./systems/hypr/hyprland.nix
    ./systems/hypr/hyprpaper.nix
    # ./systems/hyprpanel
    ./systems/waybar
    ./programs/nus
    ./programs/kitty
    ./programs/ghostty
    ./programs/fastfetch
    ./programs/fastfetch/def-comp.nix
    ./systems/hypr/polkitagent.nix
    ./programs/zenn
    ./programs/zed
    #./programs/anyrun
    ./themes
    ./systems/nwg-dock
    ./programs/rofi-launch/rasi.nix
    ./systems/swaync
    ./scripts/swaync-shot.nix
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
