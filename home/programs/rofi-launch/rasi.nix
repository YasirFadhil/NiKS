let
  improvedRasi = ''
    configuration {
      modi: "drun,run";
      show-icons: true;
      drun-display-format: "{icon} {name}";
    }

    * {
      font: "JetBrains Mono Nerd Font 13";
      background-color: #1a0d2e;
      border-radius: 12px;
      padding: 0px;
    }

    window {
      location: center;
      anchor: center;
      fullscreen: false;
      width: 500px;
      border-radius: 12px;
      background-color: #1a0d2e;
      border: 0px;
      margin: 0px;
      padding: 0px;
    }

    mainbox {
      background-color: transparent;
      border-radius: 12px;
      padding: 20px;
      children: [ "inputbar", "listview" ];
    }

    inputbar {
      background-color: #2d1955;
      border-radius: 8px;
      padding: 12px 16px;
      margin: 0px 0px 16px 0px;
      border: 0px;
    }

    prompt {
      background-color: transparent;
      text-color: #e8d5ff;
      font: "JetBrains Mono Nerd Font Bold 13";
      margin: 0px 12px 0px 0px;
    }

    entry {
      background-color: transparent;
      border: 0px;
      text-color: #e8d5ff;
      font: "JetBrains Mono Nerd Font 13";
      placeholder: "Search applications...";
      placeholder-color: #8b45ff;
      margin: 0px;
    }

    listview {
      border-radius: 8px;
      background-color: transparent;
      margin: 0px;
      padding: 0px;
      columns: 1;
      lines: 8;
      spacing: 8px;
      scrollbar: false;
      dynamic: true;
    }

    element {
      background-color: #2d1955;
      border-radius: 8px;
      padding: 12px 16px;
      text-color: #e8d5ff;
      spacing: 12px;
      font: "JetBrains Mono Nerd Font 13";
      border: 0px;
    }

    element selected {
      background-color: #8b45ff;
      border-radius: 8px;
      border: 0px;
      text-color: #ffffff;
    }

    element normal {
      background-color: #2d1955;
      text-color: #e8d5ff;
    }

    element normal.urgent {
      background-color: #ff6b9d;
      text-color: #ffffff;
    }

    element normal.active {
      background-color: #bd93f9;
      text-color: #1a0d2e;
    }

    element selected.urgent {
      background-color: #ff6b9d;
      text-color: #ffffff;
    }

    element selected.active {
      background-color: #bd93f9;
      text-color: #1a0d2e;
    }

    element-icon {
      size: 28px;
      margin: 0px 12px 0px 0px;
      background-color: transparent;
    }

    element-text {
      vertical-align: 0.5;
      text-color: inherit;
      background-color: transparent;
      font: "JetBrains Mono Nerd Font 13";
    }

    scrollbar {
      handle-width: 0px;
      background-color: transparent;
    }

    message {
      background-color: #2d1955;
      border-radius: 8px;
      border: 0px;
      padding: 12px;
      margin: 8px 0px;
    }

    textbox {
      background-color: transparent;
      text-color: #e8d5ff;
      border: 0px;
    }

    error-message {
      background-color: #2d1955;
      border: 0px;
      border-radius: 8px;
      padding: 12px;
      text-color: #ffffff;
    }
  '';
in
{
  home.file.".config/rofi/themes/improved-macos.rasi".text = improvedRasi;
}
