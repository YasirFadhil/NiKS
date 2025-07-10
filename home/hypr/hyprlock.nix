{ lib, pkgs, inputs, ... }: let
  textColor = "rgba(255,255,255,1)";
  entryBg = "rgba(51,51,51,0.07)";
  entryBorder = "rgba(59,59,59,0.33)";
  entryColor = "rgba(255,255,255,1)";
  font = "Rubik Light";
  fontSymbols = "Material Symbols Rounded";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        no_fade_in = false;
        disable_loading_bar = false;
      };

      background = lib.mkForce {
        monitor = "";
        path = "/etc/nixos/themes/pict/Nix_Ascii.png";
        # You can add blur, vibrancy, contrast if you want.
      };

      animations = {
        enabled = true;
        bezier = "ease, 0.25, 0.1, 0.25, 1.0";
        animation = [
          "windows, 1, 4, ease"
          "fade, 1, 6, ease"
          "workspaces, 1, 4, ease"
          "border, 1, 10, ease"
          "layers, 1, 6, ease"
        ];
      };

      input-field = {
        monitor = "";
        size = "250, 40";
        outline_thickness = 2;
        dots_size = 0.1;
        dots_spacing = 0.3;
        outer_color = entryBorder;
        inner_color = entryBg;
        font_color = entryColor;
        fade_on_empty = true;
        position = "0, -200";
        halign = "center";
        valign = "center";
        font_family = font;
      };

      label = [
        # Clock
        {
          monitor = "";
          text = ''cmd[update:1000] date +%I:%M'';
          shadow_passes = "1";
          shadow_boost = "0.5";
          color = textColor;
          font_size = "90";
          font_family = "Noto Sans SemiBold";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }

        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo $(date +%A) $(date +%d) $(date +%B)'';
          shadow_passes = "1";
          shadow_boost = "0.5";
          color = textColor;
          font_size = "15";
          font_family = "Noto Sans Medium";
          position = "0, 210";
          halign = "center";
          valign = "center";
        }

        # # Greeting
        # {
        #   #monitor = "";
        #   #text = "Hii Serr";
        #   shadow_passes = "1";
        #   shadow_boost = "0.5";
        #   color = textColor;
        #   font_size = "20";
        #   font_family = font;
        #   position = "0, 160";
        #   halign = "center";
        #   valign = "center";
        # }

        # Lock icon
        {
          monitor = "";
          text = "  locked";
          color = textColor;
          font_size = "18";
          font_family = fontSymbols;
          position = "0, 10";
          halign = "center";
          valign = "bottom";
        }

        # Locked text
        # {
        #   #monitor = "";
        #   #text = "locked";
        #   shadow_passes = "1";
        #   shadow_boost = "0.5";
        #   color = textColor;
        #   font_size = "14";
        #   font_family = font;
        #   position = "0, 45";
        #   halign = "center";
        #   valign = "bottom";
        # }

        # Battery
        {
          monitor = "";
          text = ''cmd[update:1000] battery'';
          shadow_passes = "1";
          shadow_boost = "0.5";
          color = textColor;
          font_size = "14";
          font_family = "Fira Code Mono Nerd";
          position = "-10, 10";
          halign = "right";
          valign = "bottom";
        }

        # Now Playing
        {
          monitor = "";
          text = ''cmd[update:5000] nowplay'';
          color = textColor;
          font_family = "Fira Code Mono Nerd";
          font_size = "14";
          position = "10, 10";
          halign = "left";
          valign = "bottom";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    hyprlock
    (import ../scripts/battery.nix { inherit pkgs; })
    (import ../scripts/nowplay.nix { inherit pkgs; })
  ];
}
