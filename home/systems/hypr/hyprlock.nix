{ lib, pkgs, inputs, ... }: let
  textColor = "rgba(255,255,255,0.95)";
  subTextColor = "rgba(255,255,255,0.7)";
  entryBg = "rgba(255,255,255,0.05)";
  entryBorder = "rgba(255,255,255,0.25)";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        disable_loading_bar = true;
        no_fade_in = false;
      };

      background = lib.mkForce {
        monitor = "";
        path = "/etc/nixos/home/themes/wallpaper/background_nix.jpg";
        blur_sigma = 8;
        vibrancy = 0.3;
        contrast = 1.05;
      };

      input-field = {
        monitor = "";
        size = "260, 42";
        outline_thickness = 1;
        outer_color = entryBorder;
        inner_color = entryBg;
        font_color = textColor;
        fade_on_empty = true;
        position = "0, -180";
        halign = "center";
        valign = "center";
        font_family = "Rubik Light";
      };

      label = [
        # JAM BESAR
        {
          monitor = "";
          text = ''cmd[update:1000] date +%H:%M'';
          color = textColor;
          font_size = "110";
          font_family = "Noto Sans SemiBold";
          position = "0, 260";
          halign = "center";
          valign = "center";
        }

        # TANGGAL
        {
          monitor = "";
          text = ''cmd[update:1000] date "+%A, %d %B"'';
          color = subTextColor;
          font_size = "20";
          font_family = "Rubik Regular";
          position = "0, 180";
          halign = "center";
          valign = "center";
        }

        # GREETING
        {
          monitor = "";
          text = ''cmd[update:60000] ${pkgs.writeShellScript "greet" ''
            hour=$(date +%H)
            if [ $hour -lt 12 ]; then
              echo "Good morning, Yassir"
            elif [ $hour -lt 18 ]; then
              echo "Good afternoon, Yassir"
            else
              echo "Good evening, Yassir"
            fi
          ''}'';
          color = "rgba(255,255,255,0.5)";
          font_size = "16";
          font_family = "Rubik Regular";
          position = "0, 15";
          halign = "center";
          valign = "bottom";
        }

        # BATTERY
        {
          monitor = "";
          text = ''cmd[update:1000] battery'';
          color = subTextColor;
          font_size = "13";
          font_family = "Fira Code Nerd Font";
          position = "-10, 15";
          halign = "right";
          valign = "bottom";
        }

        # LOCK TEXT
        #{
          #monitor = "";
          #text = "Locked";
          #color = "rgba(255,255,255,0.45)";
          #font_size = "14";
          #font_family = "Rubik Regular";
          #position = "0, 15";
          #halign = "center";
          #valign = "bottom";
        #}
      ];
    };
  };

  home.packages = with pkgs; [
    hyprlock
    (import ../../scripts/battery.nix { inherit pkgs; })
    (import ../../scripts/nowplay.nix { inherit pkgs; })
  ];
}
