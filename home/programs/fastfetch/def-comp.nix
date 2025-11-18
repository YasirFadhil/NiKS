{ config, pkgs, ... }:

{
  # Config fastfetch custom (dari yang kamu kirim di atas)
  home.file.".config/fastfetch/config-compact.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "type": "small",
        "height": 10,
        "width": 20,
        "padding": { "top": 3 }
      },
      "display": {
        "separator": " -> "
      },
      "modules": [
        "break",
        {
          "type": "title",
          "keyWidth": 10,
          "format": "         {6}{7}{8}"
        },
        {
          "type": "custom",
          "format": " ─────────────────────────── "
        },
        {
          "type": "OS",
          "key": " ",
          "keyColor": "yellow"
        },
        {
          "type": "kernel",
          "key": " ",
          "keyColor": "yellow"
        },
        {
          "type": "wm",
          "key": " ",
          "keyColor": "blue"
        },
        {
          "type": "shell",
          "key": " ",
          "keyColor": "yellow"
        },
        {
          "type": "terminal",
          "key": " ",
          "keyColor": "blue"
        },
        /*
        {
          "type": "packages",
          "key": "󰏖 ",
          "keyColor": "yellow"
        },
        */
        {
          "type": "memory",
          "key": "󰍛 ",
          "keyColor": "magenta",
          "format": "{1} / {2}"
        },
        {
          "type": "uptime",
          "key": "󰔛 ",
          "keyColor": "green"
        },
        {
          "type": "custom",
          "format": " ─────────────────────────── "
        },
        "break"
      ]
    }
  '';

  # Jika ingin konfigurasi fastfetch lain tinggal tambahkan lagi:
  # home.file.".config/fastfetch/config.jsonc".text = ''
  #   ...isi config fastfetch lain...
  # '';
}
