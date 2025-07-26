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
        background-color: rgba(40, 44, 52, 0.80);
        border-radius: 20px;
        padding: 0px;
    }

    window {
        location: center;
        anchor: center;
        fullscreen: false;
        width: 650px;
        border-radius: 20px;
        background-color: rgba(40,44,52,0.80);
        border: 0px;
        margin: 30px;
        padding: 0px;
    }

    mainbox {
        background-color: transparent;
        border-radius: 20px;
        padding: 30px 30px 20px 30px;
    }

    inputbar {
        background-color: transparent;
        margin: 0px 0px 10px 0px;
        padding: 0px;
        border-radius: 10px;
    }

    prompt {
        background-color: transparent;
        text-color: #abb2bf;
        font: "JetBrains Mono Nerd Font Bold 12";
    }

    entry {
        background-color: transparent;
        padding: 8px 0px;
        text-color: #abb2bf;
        placeholder: "Search...";
        placeholder-color: #abb2bf;
        font: "JetBrains Mono Nerd Font 12";
    }

    listview {
        border-radius: 15px;
        background-color: transparent;
        margin: 10px 0px 0px 0px;
        padding: 0px;
        columns: 1;
        lines: 10;
        spacing: 6px;
        scrollbar: true;
    }

    element {
        background-color: transparent;
        border-radius: 10px;
        padding: 7px 10px;
        text-color: #abb2bf;
    }

    element selected {
        background-color: rgba(97, 175, 239, 0.25);
        border-radius: 10px;
        text-color: #abb2bf;
    }

    element-icon {
        size: 28px;
        margin: 0px 10px 0px 0px;
    }

    element-text {
        vertical-align: 0.5;
    }

    scrollbar {
        handle-color: rgba(97, 175, 239, 0.5);
        background-color: rgba(40,44,52,0.2);
        border-radius: 10px;
        handle-width: 5px;
        margin: 0px 2px 0px 0px;
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
