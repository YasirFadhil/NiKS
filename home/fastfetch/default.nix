{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      display = {
        color = {
          output = "blue"; # warna biru seperti logo NixOS
        };
      };

      # logo = {
      #   source = ./nixos.png;
      #   height = 15;
      #   width = 30;
      #   padding = {
      #     top = 3;
      #     left = 3;
      #   };
      #   position = "left";
      # };

      modules = [
        "break"
        {
          type = "custom";
          format = "┌──────────────────────Hardware──────────────────────┐";
        }
        {
          type = "cpu";
          key = "│  ";
        }
        {
          type = "gpu";
          key = "│  ";
        }
        {
          type = "memory";
          key = "│  ";
        }
        {
          type = "disk";
          key = "│  ";
          # format = "{1} / {2}" # uncomment jika ingin tampilkan used/total
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌──────────────────────Software──────────────────────┐";
        }
        {
          type = "os";
          key = " OS -> ";
        }
        {
          type = "kernel";
          key = "│ ├ ";
        }
        {
          type = "packages";
          key = "│ ├󰏖 ";
        }
        {
          type = "shell";
          key = "└ └ ";
        }
        "break"
        {
          type = "wm";
          key = " WM";
        }
        {
          type = "wmtheme";
          key = "│ ├󰉼 ";
        }
        {
          type = "terminal";
          key = "└ └ ";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌────────────────────Uptime / Age────────────────────┐";
        }
        {
          type = "command";
          key = "│ 󱦟 ";
          text =
            # bash
            ''
              birth_install=$(stat -c %W /)
              current=$(date +%s)
              delta=$((current - birth_install))
              delta_days=$((delta / 86400))
              echo $delta_days days
            '';
        }
        {
          type = "uptime";
          key = "│  ";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        "break"
      ];
    };
  };
}
