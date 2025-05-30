{ pkgs, ... }:

let
  myPackages = import ../packages.nix {inherit pkgs;};
in
{
home.packages = myPackages;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [ "eDP-1,1700x950@60,0x0,1" ];
      exec-once = [
        "hyprpolkitagent &"
        "hyprpanel &"
        "hypridle &"
        "hyprpaper &"
        "hyprctl setcursor Bibata-Modern-Ice 20"
      ];
      input = {
        kb_model = "chromebook";
        kb_layout = "us";
        touchpad = {
          natural_scroll = true;
        };
        repeat_rate = 20;
      };
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
      bindl = [
        "SUPER, XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 ; wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        "SUPER, XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 ; wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        "SUPER, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "SUPER, XF86MonBrightnessUp, exec, brightnessctl s 2%+"
        "SUPER, XF86MonBrightnessDown, exec, brightnessctl s 2%-"
      ];
      bind = [
        "SUPER, T, exec, kitty"
        "SUPER, B, exec, zen"
        "SUPER, F, exec, thunar"
        "SUPER CTRL, V, exec, pavucontrol"
        "SUPER, D, exec, ~/Downloads/launcher.sh"
        "SUPER, X, fullscreen"
        "SUPER, Q, killactive"
        "SUPER, ESCAPE, exit"
        "SUPER, P, exec, wlogout"
        "SUPER, L, exec, hyprlock"
        "SUPER SHIFT, V, exec, wl-clipboard"

        #screenshot
        "SUPER, S, exec, grim - | tee ~/Pictures/Screenshots/screenshot_$(date +%s).png | wl-copy"
        "SUPER SHIFT, S, exec, mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"

        #window focus
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        #workspace
        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, J, movewindow, d"

        #workspace nav
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };
}
