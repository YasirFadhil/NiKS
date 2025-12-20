{ config, lib, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "SF Pro Display:style=bold:size=12, FiraCode Nerd Font Mono:style=bold:size=12";
        dpi-aware = "yes";
        pad = "25x25";
        alpha = "0.8";
        bell = "none";
      };

      cursor = {
        style = "block";
        color = "dddddd ffffff";
      };

      colors = {
        foreground = "dddddd";
        background = "000000";

        # Standard colors
        regular0 = "000000";
        regular1 = "ff5555";
        regular2 = "55ff55";
        regular3 = "ffff55";
        regular4 = "5555ff";
        regular5 = "ff55ff";
        regular6 = "55ffff";
        regular7 = "dddddd";

        # Bright colors
        bright0 = "555555";
        bright1 = "ff5555";
        bright2 = "55ff55";
        bright3 = "ffff55";
        bright4 = "5555ff";
        bright5 = "ff55ff";
        bright6 = "55ffff";
        bright7 = "ffffff";
      };

      scrollback = {
        lines = 2000;
        multiplier = 1;
      };

      selection = {
        # No selection highlight to match kitty config
      };

      key-bindings = {
        # Tab management
        "ctrl+t" = "spawn-terminal";
        "ctrl+w" = "close";

        # Split management
        "ctrl+shift+r" = "spawn-terminal -w 50%";
        "ctrl+shift+l" = "spawn-terminal -w -50%";
        "ctrl+shift+u" = "spawn-terminal -w 50%h";
        "ctrl+shift+d" = "spawn-terminal -w -50%h";

        # Navigation
        "alt+r" = "focus-pane right";
        "alt+shift+r" = "focus-pane left";
        "alt+u" = "focus-pane up";
        "alt+d" = "focus-pane down";
      };
    };
  };
}
