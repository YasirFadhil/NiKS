{ config, lib, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "SF Mono:style=bold:size=8, FiraCode Nerd Font Mono:style=bold:size=8";
        dpi-aware = "yes";
        pad = "25x25";
      };

      cursor = {
        style = "block";
      };

      colors = {
        foreground = "dddddd";
        background = "000000";
        alpha = "0.8";

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
      };

      bell = {
        urgent = "no";
        notify = "no";
      };


    };
  };
}
