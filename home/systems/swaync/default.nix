{ config, pkgs, lib, ... }:

{
  services.swaync = {
    enable = true;
    settings = {
      "$schema" = "/etc/xdg/swaync/configSchema.json";
      ignore-gtk-theme = true;
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      layer-shell-cover-screen = true;
      cssPriority = "user";
      control-center-margin-top = 7;
      control-center-margin-bottom = 0;
      control-center-margin-right = 7;
      control-center-margin-left = 0;
      notification-2fa-action = true;
      notification-inline-replies = true;
      notification-body-image-height = 100;
      notification-body-image-width = 500;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = false;
      relative-timestamps = true;
      control-center-width = 350;
      control-center-height = 600;
      notification-window-width = 350;
      keyboard-shortcuts = true;
      notification-grouping = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      text-empty = "No Notifications";
      script-fail-notify = true;
      scripts = {
        example-script = {
          exec = "echo 'Do something...'";
          urgency = "Normal";
        };
        example-action-script = {
          exec = "echo 'Do something actionable!'";
          urgency = "Normal";
          run-on = "action";
        };
      };
      notification-visibility = {
        example-name = {
          state = "muted";
          urgency = "Low";
          app-name = "Spotify";
        };
      };
      widgets = [
        "mpris"
        "title"
        "notifications"
        "buttons-grid"
      ];
      widget-config = {
        notifications = {
          vexpand = true;
        };
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 5;
          text = "Label Text";
        };
        mpris = {
          blacklist = [];
          autohide = false;
          show-album-art = "always";
          loop-carousel = false;
        };
        buttons-grid = {
          buttons-per-row = 5;
          actions = [
            {
              label = "";
              type = "button";
              command = "swaync-client --close-panel && sleep 0.7 && color=$(hyprpicker -a -f hex) && notify-send '🎨 Color copied!' $color";
            }
            {
              label = "󰹑";
              type = "button";
              command = "swaync-shot";
            }
            {
              label = "";
              type = "button";
              command = "swaync-client --close-panel && kitty --class wifibt -e env -u COLORTERM TERM=xterm-old nmtui";
            }
            {
              label = "";
              type = "button";
              command = "swaync-client --close-panel && kitty --class wifibt -e bluetuith";
            }
            {
              label = "";
              type = "toggle";
              command = "sh -c 'swaync-client --toggle-dnd'";
              update-command = "sh -c 'out=$(swaync-client -D 2>/dev/null); [[ $out == true || $(echo \"$out\" | jq -r .doNotDisturb 2>/dev/null) == true ]] && echo true || echo false'";
            }
          ];
        };
      };
    };

    style = ''
      :root {
        --cc-bg: rgba(0, 0, 0, 0.8);
        --noti-border-color: rgba(255, 255, 255, 0.15);
        --noti-bg: 40, 42, 54;
        --noti-bg-alpha: 0.95;
        --noti-bg-darker: rgb(38, 38, 38);
        --noti-bg-hover: rgba(56, 56, 56, 0.3);
        --noti-bg-focus: rgba(68, 68, 68, 0);
        --noti-close-bg: rgba(78, 78, 78, 0);
        --noti-close-bg-hover: rgba(94, 94, 94, 0);
        --text-color: rgb(255, 255, 255);
        --text-color-disabled: rgb(150, 150, 150);
        --bg-selected: rgb(0, 128, 255);
        --notification-icon-size: 64px;
        --notification-app-icon-size: calc(var(--notification-icon-size) / 3);
        --notification-group-icon-size: 32px;
        --border: 1px solid var(--noti-border-color);
        --border-radius: 12px;
        --notification-shadow: 0 0 0 0px rgba(0, 0, 0, 0.0),
          0 1px 3px 1px rgba(0, 0, 0, 0.7), 0 2px 6px 2px rgba(0, 0, 0, 0.3);
        --font-size-body: 15px;
        --font-size-summary: 16px;
        /* Deprecated variables (because of their typos). Keeeping them around for backwards compatibility. */
        --hover-tranistion: background 0.15s ease-in-out;
        --group-collapse-tranistion: opacity 400ms ease-in-out;
        --hover-transition: var(--hover-tranistion);
        --group-collapse-transition: var(--group-collapse-tranistion);
      }

      /* Fallback for older CSS themes */
      @define-color cc-bg rgba(40, 42, 54, 0.95);
      @define-color noti-border-color rgba(255, 255, 255, 0.15);
      @define-color noti-bg rgba(40, 42, 54, 0.95);
      @define-color noti-bg-opaque rgb(48, 48, 48);
      @define-color noti-bg-darker rgb(38, 38, 38);
      @define-color noti-bg-hover rgb(56, 56, 56);
      @define-color noti-bg-hover-opaque rgb(56, 56, 56);
      @define-color noti-bg-focus rgba(68, 68, 68, 0.6);
      @define-color noti-close-bg rgba(255, 255, 255, 0.1);
      @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);
      @define-color text-color rgb(255, 255, 255);
      @define-color text-color-disabled rgb(150, 150, 150);
      @define-color bg-selected rgb(0, 128, 255);

      notificationwindow, blankwindow, blankwindow {
        background: transparent;
      }

      .close-button {
        background: var(--noti-close-bg);
        color: var(--text-color);
        text-shadow: none;
        padding: 0;
        border-radius: 100%;
        margin-top: 8px;
        margin-right: 8px;
        box-shadow: none;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }

      .close-button:hover {
        box-shadow: none;
        background: var(--noti-close-bg-hover);
        transition: var(--hover-tranistion);
        border: none;
      }

      .notification-row {
        background: none;
        outline: none;
      }

      .notification-row:focus {
        background: var(--noti-bg-focus);
      }

      .notification-row .notification-background {
        padding: 6px 12px;
      }

      .notification-row .notification-background .notification {
        border-radius: var(--border-radius);
        border: var(--border);
        padding: 0;
        transition: var(--hover-tranistion);
        background: rgba(var(--noti-bg), var(--noti-bg-alpha));
      }

      .notification-row .notification-background .notification .notification-default-action {
        padding: 4px;
        margin: 0;
        box-shadow: none;
        background: transparent;
        border: none;
        color: var(--text-color);
        transition: var(--hover-tranistion);
        border-radius: var(--border-radius);
      }

      .mpris {
          background: rgba(40, 42, 54, 0.8);
          border-radius: 12px;
          margin: 8px;
          padding: 8px;
          transform: scale(0.8);    /* Shrinks entire widget */
          transform-origin: top center;
      }


      .mpris-player {
          display: flex;
          flex-direction: column;
          align-items: center;
          text-align: center;
      }

      .mpris-title {
          font-size: 12px;
          font-weight: bold;
          color: white;
      }

      .mpris-artist {
          font-size: 10px;
          color: rgba(255, 255, 255, 0.7);
      }

      .mpris-controls {
          display: flex;
          justify-content: center;
          margin-top: 6px;
          gap: 10px;
      }

      .mpris-button {
          font-size: 18px;
          color: white;
          opacity: 0.8;
      }

      .mpris-button:hover {
          opacity: 1;
      }

      .mpris,
      .mpris-player,
      .widget.mpris {
          box-shadow: none;
          border: none;
          background-clip: padding-box;
      }

      .widget-buttons-grid {
          margin: 6px;
          padding: 4px;
          display: flex;
          justify-content: center;
          gap: 8px;
      }

      .widget-buttons-grid button {
          background: rgba(98, 114, 164, 0.7);
          border-radius: 10px;
          padding: 8px 12px;
          font-size: 18px;
          color: #ffffff;
          transition: background 0.2s ease, transform 0.1s ease;
      }

      .widget-buttons-grid button:hover {
          transform: scale(1.1);
      }

      .widget-buttons-grid button:checked {
          background: rgba(255, 85, 85, 0.8);
          color: #ffffff;
      }

      .widget-title {
          margin-top: 0px;
          margin-left: 3px;
          margin-right: 3px;
      }

      .widget-mpris {
          margin-bottom: 0px;
          margin-top: -3px;
          margin-left: -8px;
          margin-right: -8px
      }

      .widget-notifications {
          margin-bottom: 0px;
          margin-top: -15px;
          margin-left: -10px;
          margin-right: -10px
      }
    '';
  };
}
