{ input, pkgs, ... }:

let
  myPackages = import ../package.nix {inherit pkgs;};
in
{
  imports = [
    ./polkitagent.nix
    ./binds.nix
    #./hyprpaper.nix
    ./env.nix
  ];

  home.packages = myPackages;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [
        "eDP-1,1700x950@60,0x0,1"
        # "HDMI-1,1920x1080@60,1700x0,0"
      ];
      exec-once = [
        "polkit-gnome-authentication-agent-1"
        "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,pgp"
        "systemctl --user stop dunst &"
        "hyprpanel &"
        # "waybar &"
        "hypridle &"
        "hyprpaper &"
        "nm-applet &"
        "blueman-applet &"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "hyprctl setcursor Bibata-Modern-Ice 20"
        "nwg-dock-hyprland -d -i 30 -ml 12 -mr 12 -mb 12 -nolauncher -x -l bottom"
      ];
      input = {
        kb_model = "chromebook";
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        repeat_delay = 300;
        repeat_rate = 50;

        #trackpad
        touchpad = {
          natural_scroll = true;
        };
      };
      gestures = {workspace_swipe = true;};
      general = {
        gaps_in = 7;
        gaps_out = 15;
        gaps_workspaces = 50;
        border_size = 0;
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
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
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
      windowrule = [
        "float, title:^(Volume Control)$"
        "float, title:^(Waypaper)$"
        "float, title:^(KDE Connect)$"
        "size 1035 661, title:^(KDE Connect)$"
      ];
    };
  };
}
