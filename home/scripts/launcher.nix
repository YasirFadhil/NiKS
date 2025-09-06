{ pkgs }:

pkgs.writeShellScriptBin "rofi-launcher" ''
  rofi -show drun -theme "$HOME/.config/rofi/themes/improved-macos.rasi"
''
