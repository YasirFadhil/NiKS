{ pkgs, ... }:

let
  myPackages = import ../packages.nix {inherit pkgs;};
in
{
  imports = [
    ./polkitagent.nix
    ./binds.nix
    ../hyprpanel/default.nix
  ];

  home.packages = myPackages;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [ "eDP-1,1700x950@60,0x0,1" ];
      exec-once = [
        "polkit-gnome-authentication-agent-1"
        "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,pgp"
        "hyprpanel &"
        "hypridle &"
        "hyprpaper &"
        "hyprctl setcursor Bibata-Modern-Ice 20"
      ];
      input = {
        kb_model = "chromebook";
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0.5;
        repeat_delay = 300;
        repeat_rate = 50;

        #trackpad
        touchpad = {
          natural_scroll = true;
        };
      };
      gestures = {workspace_swipe = true;};
      general = {
        gaps_in = 8;
        gaps_out = 13;
        border_size = 1;
        # col.active_border = "rgba(33ccffee)";
        # col.inactive_border = "rgba(595959aa)";
      };
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
        };
      };
      animations = {
        enabled = true;
        bezier = [ "myBezier,0.05,0.9,0.1,1.05" ];
        animation = [ "windows,1,7,myBezier" ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
    };
  };
}
