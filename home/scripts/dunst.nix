{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellScript "kill-dunst" ''
  ${pkgs.procps}/bin/pkill dunst
''