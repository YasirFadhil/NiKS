{
  pkgs,
  inputs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    settings = {
      # Font configuration
      font-family = "SF Pro Display, FiraCode Nerd Font Mono";
      font-size = 12;
      font-style = "bold";
      bold-is-bright = true;

      # Window configuration
      window-padding-x = 25;
      window-padding-y = 25;
      background-opacity = 0.8;
      confirm-close-surface = false;

      # Theme configuration
      theme = "Argonaut";
      foreground = "#dddddd";
      background = "#000000";
      cursor-color = "#dddddd";
      cursor-text = "#EAAEBA";

      # Mouse & other
      mouse-hide-while-typing = true;
      cursor-style = "block";

      # Keybinds
      keybind = [
        "ctrl+t=new_tab"
        "ctrl+w=close_tab"
        "ctrl+shift+r=new_split:right"
        "ctrl+shift+l=new_split:left"
        "ctrl+shift+u=new_split:up"
        "ctrl+shift+d=new_split:down"
        "alt+r=goto_split:right"
        "alt+shift+r=goto_split:left"
        "alt+u=goto_split:up"
        "alt+d=goto_split:down"
      ];
    };
  };
}
