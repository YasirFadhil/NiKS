{ inputs, pkgs, lib, ... }:

let
  myPackages = import ../package.nix {inherit pkgs;};
in
{
  imports = [
    ./polkitagent.nix
    ./binds.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./env.nix
    ./animation.nix
  ];

  home.packages = myPackages;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [
        "eDP-1,1700x950@60,0x0,1"
      ];
      exec-once = [
        "polkit-gnome-authentication-agent-1"
        "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,pgp"
        # "hyprpanel &"
        # "filebrowser --address 0.0.0.0 &"
        # "waybar &"
        "kdeconnect-indicator"
        "hypridle &"
        "hyprpaper &"
        "waypaper --restore"
        "nm-applet &"
        "blueman-applet &"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "hyprctl setcursor Bibata-Modern-Ice 20"
        "nwg-dock-hyprland -r -i 30 -ml 12 -mr 12 -mb 12 -nolauncher -x -l bottom"
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
      # gestures = {workspace_swipe = true;};
      general = {
        gaps_in = 7;
        gaps_out = 15;
        gaps_workspaces = 50;
        border_size = 0;
        "col.active_border" = "rgb(4575da) rgb(6804b5)"; #"rgba(33ccffee)";
        "col.inactive_border" = "rgb(595959)";
      };
      decoration = {
        active_opacity = 0.75;
        inactive_opacity = 0.73;
        rounding = 14;
        blur = {
          enabled = true;
          size = 8;            # lebih tinggi = blur lebih tebal (coba 18 - 32)
          passes = 3;           # lebih tinggi = lebih smooth (coba 4 - 8)
          vibrancy = 0.33;      # lebih tinggi = warna di bawah lebih keluar (coba 0.22 - 0.4)
          #new_optimizations = true;
          #ignore_opacity = false;
        };
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
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
        "size 872 515, title:^(Volume Control)$"
        "float, class:^(org.gnome.Calculator)$"
        "size 567 734, class:^(org.gnome.Calculator)$"
        "float, title:^(Waypaper)$"
        "float, title:^(KDE Connect)$"
        "float, title:^(WhatsApp — KDE Connect Daemon)$"
        "float, class:^(org.kde.kdeconnect.daemon)$"
        "size 1035 661, title:^(KDE Connect)$"
        "float,class:^(floating-kitty)$"
        "size 1094 633,class:^(floating-kitty)$"
      ];
    };
  };
}
