{ pkgs }:

pkgs.writeShellScriptBin "swaylock-blur" ''
  #!/usr/bin/env bash

  # Swaylock with blur effects wrapper script
  # Usage: swaylock-blur

  ${pkgs.swaylock-effects}/bin/swaylock \
    --screenshots \
    --effect-blur 7x5 \
    --effect-vignette 0.5:0.5 \
    --fade-in 0.2 \
    --clock \
    --indicator-idle-visible \
    --color 000000aa \
    --inside-color ffffff22 \
    --inside-clear-color ffffff22 \
    --inside-caps-lock-color ffffff22 \
    --inside-ver-color ffffff66 \
    --inside-wrong-color ff000066 \
    --ring-color ffffff88 \
    --ring-clear-color ffffff88 \
    --ring-caps-lock-color ffffff88 \
    --ring-ver-color ffffffaa \
    --ring-wrong-color ff0000aa \
    --key-hl-color ffffffcc \
    --line-color 00000000 \
    --line-clear-color 00000000 \
    --line-caps-lock-color 00000000 \
    --line-ver-color 00000000 \
    --line-wrong-color 00000000 \
    --text-color ffffffff \
    --text-clear-color ffffffff \
    --text-caps-lock-color ffffffff \
    --text-ver-color ffffffff \
    --text-wrong-color ffffffff \
    --separator-color 00000000 \
    --font "Rubik Light" \
    --font-size 16 \
    --indicator-radius 120 \
    --indicator-thickness 3 \
    --timestr "%H:%M" \
    --datestr "%A, %d %B" \
    --clock-font-size 85 \
    --indicator-x-position 0 \
    --indicator-y-position -80 \
    --grace 0 \
    --caps-lock-key-hl-color ffffffff \
    --caps-lock-bs-hl-color ffffffff \
    --layout-font-size 0 \
    --layout-text-color 00000000
''
