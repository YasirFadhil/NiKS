{pkgs, ...}:
{
  home.packages = with pkgs; [
    (import ../scripts/volume.nix { inherit pkgs ; })
    (import ../scripts/launcher.nix { pkgs = pkgs; })
  ];

  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER, mouse:272, movewindow" # Move Window (mouse)
      "SUPER, mouse:273, resizewindow" # Resize Window (mouse)
    ];
    bindl = [
      ",XF86AudioRaiseVolume, exec, volume-control up"
      ",XF86AudioLowerVolume, exec, volume-control down"
      ",XF86AudioMute, exec, volume-control mute"
      ",XF86MonBrightnessUp, exec, brightnessctl s 2%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 2%-"
    ];
    bind = [
      "SUPER, T, exec, kitty"
      "SUPER SHIFT, T, exec, kitty --class floating-kitty"
      "SUPER, B, exec, zen"
      "SUPER, E, exec, rofimoji"
      #"SUPER, F, exec, thunar"
      "SUPER, F, exec, nautilus"
      "SUPER CTRL, V, exec, pavucontrol"
      # "SUPER, D, exec, ~/.config/rofi/launchers/type-1/launcher.sh"
      "SUPER, D, exec, rofi-launcher"
      "SUPER, X, fullscreen"
      "SUPER, Q, killactive"
      "SUPER, ESCAPE, exit"
      "SUPER, P, exec, wlogout"
      "SUPER, L, exec, hyprlock"
      "SUPER SHIFT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      "SUPER ALT, B, exec, hyprpanel -q; hyprpanel"
      "SUPER, W, exec, waypaper"
      "SUPER SHIFT, W, exec, nwg-dock-hyprland"
      "SUPER, M, togglefloating" # floating toggle

      #screenshot
      "SUPER, S, exec, grim - | tee ~/Pictures/Screenshots/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"
      "SUPER SHIFT, S, exec, mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/screenreg-$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"

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
}
