let
  improvedRasi = ''
    configuration {
      modi: "drun,run";
      show-icons: true;
      drun-display-format: "{icon} {name}";
    }

    * {
      font: "JetBrains Mono Nerd Font 13";
      background-color: #7828d434; // biru-abu gelap transparan
      border-radius: 24px;
      padding: 0px;
    }

    window {
      location: center;
      anchor: center;
      fullscreen: false;
      width: 500px;
      border-radius: 24px;
      background-color: #7828d434;
      border: 0px;
      margin: 0px;
      padding: 0px;
    }

    mainbox {
      background-color: transparent;
      border-radius: 24px;
      padding: 25px 24px 18px 24px;
      children: [ "inputbar", "listview" ];
    }

    inputbar {
      background-color: #8128b434;
      border-radius: 14px;
      padding: 13px 16px;
      margin: 0px 0px 10px 0px;
    }

    prompt {
      background-color: transparent;
      text-color: #cdd6f4;
      font: "JetBrains Mono Nerd Font Bold 13";
      margin: 0px 12px 0px 0px;
    }

    entry {
      background-color: transparent;
      border: 0px;
      text-color: #cdd6f4;
      font: "JetBrains Mono Nerd Font 13";
      placeholder: "Search…";
      placeholder-color: #9d88b0ff;
      margin: 0px;
    }

    listview {
      border-radius: 16px;
      background-color: transparent;
      margin: 0px;
      padding: 0px;
      columns: 1;
      lines: 7;
      spacing: 11px;
      scrollbar: false;
      dynamic: true;
    }

    element {
      background-color: #2f283334;
      border-radius: 10px;
      padding: 10px 14px;
      text-color: #cdd6f4;
      spacing: 13px;
      font: "JetBrains Mono Nerd Font 13";
    }
    element selected {
      background-color: #6d3e80af; // biru highlight transparan
      border-radius: 10px;
      text-color: #cdd6f4;
    }
    element-icon {
      size: 26px;
      margin: 0px 12px 0px 0px;
    }
    element-text {
      vertical-align: 0.5;
    }

    scrollbar { handle-width: 0px; background-color: transparent; }

    message, textbox, error-message { background-color: transparent; border: 0px; }
  '';
in
{
  home.file.".config/rofi/themes/improved-macos.rasi".text = improvedRasi;
}
