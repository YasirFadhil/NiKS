{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      bezier = [
        "shot, 0.02, 1.0, 0.2, 1.0"
        "swipe, 0.6, 0.0, 0.2, 1.05"
        "linear, 0.0, 0.0, 1.0, 1.0"
        "progressive, 1.0, 0.0, 0.6, 1.0"
      ];

      animation = [
        "windows, 1, 6, shot, slide"
        "workspaces, 1, 6, swipe, slide"
        "fade, 1, 4, progressive"
      ];
    };
  };
}
