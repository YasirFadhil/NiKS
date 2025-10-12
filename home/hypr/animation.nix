{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      bezier = [
        "smoothOut, 0.36, 0, 0.66, -0.56"
        "smoothIn, 0.25, 1, 0.5, 1"
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "workspace, 0.1, 0.5, 0.5, 1.2"
      ];

      animation = [
        "windows, 1, 4, smoothIn, slide"
        "windowsOut, 1, 4, smoothOut, slide"
        "border, 1, 10, default"
        "fade, 1, 5, smoothIn"
        "workspaces, 1, 6, workspace, slide"
      ];
    };
  };
}
