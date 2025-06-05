{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
    (import ../scripts/battery.nix { inherit pkgs ; })
  ];

  xdg.configFile."hypr/hyprlock.conf".text = ''
    $text_color = rgba(FFFFFFFF)
    $entry_background_color = rgba(33333311)
    $entry_border_color = rgba(3B3B3B55)
    $entry_color = rgba(FFFFFFFF)
    $font_family = Rubik Light
    $font_family_clock = Rubik Light
    $font_material_symbols = Material Symbols Rounded

    animations {
        enabled = true
        bezier = ease, 0.25, 0.1, 0.25, 1.0
        animation = windows, 1, 4, ease
        animation = fade, 1, 6, ease
        animation = workspaces, 1, 4, ease
        animation = border, 1, 10, ease
        animation = layers, 1, 6, ease
    }

    background {
        color = rgba(000000FF)
        path = /home/yasirfadhil/Pictures/Fuji.jpg
        blur_size = 2
        blur_passes = 2
    }
    input-field {
        monitor =
        size = 250, 40
        outline_thickness = 2
        dots_size = 0.1
        dots_spacing = 0.3
        outer_color = $entry_border_color
        inner_color = $entry_background_color
        font_color = $entry_color
        # fade_on_empty = true

        position = 0, -200
        halign = center
        valign = center
    }

    label { # Clock
        monitor =
        text = cmd[update:1000] date +%I:%M
        shadow_passes = 1
        shadow_boost = 0.5
        color = $text_color
        font_size = 75
        font_family = Noto Sans SemiBold
        position = 0, 280
        halign = center
        valign = center
    }
    label { #Date
      monitor =
      text = cmd[update:1000] echo $(date +%A) $(date +%d) $(date +%B)
      shadow_passes = 1
      shadow_boost = 0.5
      color = $text_color
      font_size = 15
      font_family = Noto Sans Medium
      position = 0, 210
      halign = center
      valign = center
    }
    label { # Greeting
        monitor =
        text = Hii Serr
        shadow_passes = 1
        shadow_boost = 0.5
        color = $text_color
        font_size = 20
        font_family = $font_family
        position = 0, 160
        halign = center
        valign = center
    }
    label { # lock icon
        monitor =
        text =   locked
        color = $text_color
        font_size = 18
        font_family = $font_material_symbols
        position = 0, 10
        halign = center
        valign = bottom
    }
    #label { # "locked" text
    #    monitor =
        shadow_passes = 1
        shadow_boost = 0.5
        color = $text_color
        font_size = 14
        font_family = $font_family
        position = 0, 45
        halign = center
        valign = bottom
    }
    label { # Status
        monitor =
        # text = cmd[update:1000]~/.config/hypr/scripts/battery.sh
        text = cmd[update:1000] battery
        shadow_passes = 1
        shadow_boost = 0.5
        color = $text_color
        font_size = 14
        font_family = Fira Code Mono Nerd
        position = -10, 10
        halign = right
        valign = bottom
    }
    label { #Music
        monitor =
        text = cmd[update:5000] ~/.config/hypr/scripts/nowplay.sh
        color = $text_color
        font_family = Fira Code Mono Nerd
        font_size = 14
        position = 0, 0
        halign = left
        valign = bottom
    }
  '';
}
