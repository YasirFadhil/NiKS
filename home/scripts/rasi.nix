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
        modi:                       "drun,run,filebrowser,window";
        show-icons:                 true;
        display-drun:               "";
        display-run:                "";
        display-filebrowser:        "";
        display-window:             "";
        drun-display-format:        "{name}";
        window-format:              "{w} · {c} · {t}";
        font:                       "JetBrains Mono Nerd Font 10";
        window-class:               "rofi-blur";
        window-name:                "rofi-blur";
    }

    /*****----- Global Properties -----*****/
    @import                          "shared/colors.rasi"
    @import                          "shared/fonts.rasi"

    * {
        border-colour:               var(selected);
        handle-colour:               var(selected);
        background-colour:           var(background);
        foreground-colour:           var(foreground);
        alternate-background:        var(background-alt);
        normal-background:           var(background);
        normal-foreground:           var(foreground);
        urgent-background:           var(urgent);
        urgent-foreground:           var(background);
        active-background:           var(active);
        active-foreground:           var(background);
        selected-normal-background:  var(selected);
        selected-normal-foreground:  var(background);
        selected-urgent-background:  var(active);
        selected-urgent-foreground:  var(background);
        selected-active-background:  var(urgent);
        selected-active-foreground:  var(background);
        alternate-normal-background: var(background);
        alternate-normal-foreground: var(foreground);
        alternate-urgent-background: var(urgent);
        alternate-urgent-foreground: var(background);
        alternate-active-background: var(active);
        alternate-active-foreground: var(background);
    }

    /*****----- Main Window -----*****/
    window {
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       600px;
        x-offset:                    0px;
        y-offset:                    0px;

        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        cursor:                      "default";
        background-color:            rgba(40, 44, 52, 0.2);
    }

    mainbox {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     30px;
        border:                      0px solid;
        border-radius:               0px 0px 0px 0px;
        border-color:                @border-colour;
        background-color:            rgba(40, 44, 52, 0.0);
        children:                    [ "inputbar", "message", "listview" ];
    }

    inputbar {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            rgba(40, 44, 52, 0.0);
        text-color:                  @foreground-colour;
        children:                    [ "textbox-prompt-colon", "entry", "mode-switcher" ];
    }

    prompt {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
    }
    textbox-prompt-colon {
        enabled:                     true;
        padding:                     5px 0px;
        expand:                      false;
        str:                         "";
        background-color:            inherit;
        text-color:                  inherit;
    }
    entry {
        enabled:                     true;
        padding:                     5px 0px;
        background-color:            inherit;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "Search...";
        placeholder-color:           inherit;
    }
    num-filtered-rows {
        enabled:                     true;
        expand:                      false;
        background-color:            inherit;
        text-color:                  inherit;
    }
    textbox-num-sep {
        enabled:                     true;
        expand:                      false;
        str:                         "/";
        background-color:            inherit;
        text-color:                  inherit;
    }
    num-rows {
        enabled:                     true;
        expand:                      false;
        background-color:            inherit;
        text-color:                  inherit;
    }
    case-indicator {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
    }
    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       8;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   true;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
        spacing:                     5px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
        cursor:                      "default";
    }
    scrollbar {
        handle-width:                5px ;
        handle-color:                @handle-colour;
        border-radius:               10px;
        background-color:            rgba(61, 70, 79, 0.6);
    }
    element {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     5px 10px;
        border:                      0px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
        cursor:                      pointer;
    }
    element normal.normal {
        background-color:            transparent;
        text-color:                  var(normal-foreground);
    }
    element normal.urgent {
        background-color:            transparent;
        text-color:                  var(urgent-foreground);
    }
    element normal.active {
        background-color:            transparent;
        text-color:                  var(active-foreground);
    }
    element selected.normal {
        background-color:            rgba(97, 175, 239, 0.2);
        text-color:                  var(selected-normal-foreground);
    }
    element selected.urgent {
        background-color:            rgba(224, 108, 117, 0.2);
        text-color:                  var(selected-urgent-foreground);
    }
    element selected.active {
        background-color:            rgba(152, 195, 121, 0.2);
        text-color:                  var(selected-active-foreground);
    }
    element alternate.normal {
        background-color:            transparent;
        text-color:                  var(alternate-normal-foreground);
    }
    element alternate.urgent {
        background-color:            transparent;
        text-color:                  var(alternate-urgent-foreground);
    }
    element alternate.active {
        background-color:            transparent;
        text-color:                  var(alternate-active-foreground);
    }
    element-icon {
        background-color:            transparent;
        text-color:                  inherit;
        size:                        24px;
        cursor:                      inherit;
    }
    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        highlight:                   inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }
    mode-switcher{
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
    }
    button {
        padding:                     5px 10px;
        border:                      0px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        background-color:            rgba(61, 70, 79, 0.7);
        text-color:                  inherit;
        cursor:                      pointer;
    }
    button selected {
        background-color:            var(selected-normal-background);
        text-color:                  var(selected-normal-foreground);
    }
    message {
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px 0px 0px 0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
    }
    textbox {
        padding:                     8px 10px;
        border:                      0px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        background-color:            rgba(61, 70, 79, 0.7);
        text-color:                  @foreground-colour;
        vertical-align:              0.5;
        horizontal-align:            0.0;
        highlight:                   none;
        placeholder-color:           @foreground-colour;
        blink:                       true;
        markup:                      true;
    }
    error-message {
        padding:                     10px;
        border:                      2px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        background-color:            rgba(40, 44, 52, 0.3);
        text-color:                  @foreground-colour;
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
