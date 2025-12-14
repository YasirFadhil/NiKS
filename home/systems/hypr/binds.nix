{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Mouse bindings
    bindm = [
      "SUPER, mouse:272, movewindow"    # Move window with mouse
      "SUPER, mouse:273, resizewindow"  # Resize window with mouse
    ];

    # Media and hardware control (repeatable, locked, works in fullscreen)
    bindel = [
      # Volume controls
      ",XF86AudioRaiseVolume, exec, volume-control up"
      ",XF86AudioLowerVolume, exec, volume-control down"
      ",XF86AudioMute, exec, volume-control mute"

      # Audio sink switching
      ",XF86AudioNext, exec, audio-sink --toggle"
      ",XF86AudioPrev, exec, audio-sink --status"

      # Brightness controls
      ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];

    # Locked bindings (work in fullscreen)
    bindl = [
      # Workspace switching
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

      # Application launchers (locked for fullscreen)
      "SUPER, T, exec, ghostty"
      "SUPER SHIFT, RETURN, exec, ghostty --class floating-term"
      "SUPER, B, exec, zen"
      "SUPER, E, exec, rofimoji"
      "SUPER, F, exec, nautilus"
      "SUPER CTRL, V, exec, pavucontrol"
      "SUPER, D, exec, rofi-launcher"

      # System controls
      "SUPER, X, fullscreen"
      "SUPER, Q, killactive"
      "SUPER, ESCAPE, exit"
      "SUPER, P, exec, wlogout"
      "SUPER, L, exec, hyprlock"
      "SUPER, M, togglefloating"

      # Window focus controls (locked)
      "SUPER, H, movefocus, l"
      "SUPER SHIFT, L, movefocus, r"
      "SUPER, K, movefocus, u"
      "SUPER, J, movefocus, d"

      # Window movement (locked)
      "SUPER SHIFT, H, movewindow, l"
      "SUPER CTRL, L, movewindow, r"
      "SUPER SHIFT, K, movewindow, u"
      "SUPER SHIFT, J, movewindow, d"

      # Move windows to workspaces (locked)
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

      # Alternative workspace navigation
      "ALT, TAB, workspace, e+1"
      "ALT SHIFT, TAB, workspace, e-1"

      # Screenshot functionality
      "SUPER, S, exec, grim - | tee ~/Pictures/Screenshots/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"
      "SUPER SHIFT, S, exec, mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/Screenreg-$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"
    ];

    # Regular bindings (for non-fullscreen scenarios)
    bind = [
      # Utility functions
      "SUPER SHIFT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      "SUPER ALT, B, exec, hyprpanel -q; hyprpanel"
      "SUPER, W, exec, waypaper"
      "SUPER SHIFT, W, exec, nwg-dock-hyprland"

      # Additional screenshot bindings
      "SUPER, F5, exec, grim - | tee ~/Pictures/Screenshots/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy"
      "SUPER SHIFT, H, exec, hyprshot -m output | wl-copy"

      # Audio sink switching
      "SUPER ALT, A, exec, audio-sink --toggle"
    ];
  };
}
