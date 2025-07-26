{ config, ... }:

let
  style5Rasi = ''
    /**
     *
     * Author : Aditya Shakya (adi1090x)
     * Github : @adi1090x
     *
     * Rofi Theme File
     * Rofi Version: 1.7.3
     **/

    /*****----- Configuration -----*****/
    configuration {
          modi: "drun,run";
          show-icons: true;
          drun-display-format: "{icon} {name}";
        }

        * {
          font: "JetBrains Mono Nerd Font 12";
          background-color: rgba(30, 32, 48, 0.83);
          border-radius: 28px;
          padding: 0px;
        }

        window {
          location: center;
          anchor: center;
          fullscreen: false;
          width: 580px;
          border-radius: 28px;
          background-color: rgba(30,32,48,0.83);
          border: 0px;
          margin: 0px;
          padding: 0px;
          /* Optional: shadow, jika didukung */
          box-shadow: 0px 8px 32px 0px rgba(0,0,0,0.20);
        }

        mainbox {
          background-color: transparent;
          border-radius: 28px;
          padding: 38px 34px 24px 34px;
        }

        prompt {
          background-color: transparent;
          text-color: #cdd6f4;
          font: "JetBrains Mono Nerd Font Bold 14";
          margin: 0px 0px 8px 0px;
        }

        entry {
          background-color: rgba(44, 46, 66, 0.72);
          padding: 12px 18px;
          border-radius: 12px;
          text-color: #cdd6f4;
          font: "JetBrains Mono Nerd Font 13";
          margin: 0px 0px 22px 0px;
          placeholder: "Search...";
          placeholder-color: #8892b0;
        }

        listview {
          border-radius: 20px;
          background-color: transparent;
          margin: 0px 0px 0px 0px;
          padding: 0px;
          columns: 1;
          lines: 10;
          spacing: 15px;
          scrollbar: true;
        }

        element {
          background-color: rgba(44, 46, 66, 0.38);
          border-radius: 15px;
          padding: 10px 16px;
          text-color: #cdd6f4;
          spacing: 16px;
          font: "JetBrains Mono Nerd Font 13";
        }
        element selected {
          background-color: rgba(97, 175, 239, 0.24);
          border-radius: 15px;
          text-color: #cdd6f4;
        }
        element-icon {
          size: 32px;
          margin: 0px 18px 0px 0px;
        }
        element-text {
          vertical-align: 0.5;
        }
        scrollbar {
          handle-color: rgba(97, 175, 239, 0.48);
          background-color: rgba(30,32,48,0.16);
          border-radius: 10px;
          handle-width: 6px;
          margin: 0px 2px 0px 0px;
        }
      }
    }
    '';

  colorsRasi = ''
    /**
     *
     * Author : Aditya Shakya (adi1090x)
     * Github : @adi1090x
     *
     * Colors
     *
     * Available Colors Schemes
     *
     * adapta    catppuccin    everforest    navy       paper
     * arc       cyberpunk     gruvbox       nord       solarized
     * black     dracula       lovelace      onedark    yousai
     *
     **/

    /* Import color-scheme from `colors` directory */

    @import "~/.config/rofi/colors/onedark.rasi"
  '';

  fontsRasi = ''
    /**
     *
     * Author : Aditya Shakya (adi1090x)
     * Github : @adi1090x
     *
     * Fonts
     *
     **/

    * {
        font: "JetBrains Mono Nerd Font 10";
    }
  '';
in
{
  home.file.".config/rofi/themes/style-5.rasi".text = style5Rasi;
  home.file.".config/rofi/themes/shared/colors.rasi".text = colorsRasi;
  home.file.".config/rofi/themes/shared/fonts.rasi".text = fontsRasi;
  home.file.".config/rofi/colors/onedark.rasi".source = ./colors/onedark.rasi;

  # Optional: set rofi to use this theme by default
  # programs.rofi = {
  #   enable = true;
  #   theme = "${config.home.homeDirectory}/.config/rofi/themes/style-5.rasi";
  # };
}
