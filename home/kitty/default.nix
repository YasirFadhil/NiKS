{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      include = "./kitty-themes/00-Default.conf";

      font_family = "FiraCode Nerd Font Mono Bold";
      font_size = "12.0";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      background_opacity = "0.8";
      dynamic_background_opacity = "1";
      confirm_os_window_close = "0";

      cursor_trail = "1";
      linux_display_server = "auto";

      scrollback_lines = "2000";
      wheel_scroll_min_lines = "1";

      enable_audio_bell = "no";
      window_padding_width = "25";

      selection_foreground = "none";
      selection_background = "none";

      foreground = "#dddddd";
      background = "#000000";
      cursor = "#dddddd";
    };
  };
}
