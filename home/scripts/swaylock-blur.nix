{ pkgs }:

pkgs.writeShellScriptBin "swaylock-blur" ''
  #!/usr/bin/env bash

  # Swaylock with blur effects wrapper script
  # Usage: swaylock-blur

  ${pkgs.swaylock-effects}/bin/swaylock \
    --screenshots \
    --effect-blur 7x5 \
    --effect-vignette 0.5:0.5 \
    --fade-in 0.1 \
    --clock \
    --indicator-idle-visible \
    --color 000000aa \
    --inside-color ffffff22 \
    --inside-clear-color ffffff22 \
    --inside-caps-lock-color ffffff22 \
    --inside-ver-color ffffff66 \
    --inside-wrong-color ff000066 \
    --ring-color ffffffee \
    --ring-clear-color ffffffee \
    --ring-caps-lock-color ffff00ee \
    --ring-ver-color 00ff00ee \
    --ring-wrong-color ff0000ff \
    --key-hl-color 0099ffff \
    --line-color 00000000 \
    --line-clear-color 00000000 \
    --line-caps-lock-color 00000000 \
    --line-ver-color 0099ffff \
    --line-wrong-color ff0000ff \
    --text-color ffffffff \
    --text-clear-color ffffffff \
    --text-caps-lock-color ffff00ff \
    --text-ver-color 00ff00ff \
    --text-wrong-color ff0000ff \
    --separator-color 00000000 \
    --font "Noto Sans SemiBold" \
    --font-size 28 \
    --indicator-radius 110 \
    --indicator-thickness 8 \
    --timestr "%I:%M %p" \
    --datestr "%b %d, %Y" \
    --grace 0 \
    --caps-lock-key-hl-color ffffffff \
    --caps-lock-bs-hl-color ffffffff
''
