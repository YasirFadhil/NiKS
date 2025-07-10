# { pkgs ? import <nixpkgs> {} }:

# let
#   home = builtins.getEnv "HOME";
#   dir = "${home}/.config/rofi/launchers/type-1";
#   theme = "style-5";
# in
# pkgs.writeShellScript "rofi-launcher" ''
#   rofi \
#     -show drun \
#     -theme ${dir}/${theme}.rasi
# ''

{ pkgs }:

pkgs.writeShellScriptBin "rofi-launcher" ''
  rofi -show drun -theme "$HOME/.config/rofi/launchers/type-1/style-5.rasi"
''
