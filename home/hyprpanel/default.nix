{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ hyprpanel ];

  home.file.".config/hyprpanel/config.json".text = builtins.toJSON {
    theme = {
      font = {
        size = "1rem";
        weight = 700;
        name = "Ubuntu Nerd Font";
      };
      bar = {
        transparent = true;
        floating = true;
        scaling = 100;
        buttons = {
          enableBorders = false;
          borderSize = "0.1em";
          y_margins = "-0.1em";
          radius = "0.7em";
          dashboard = {
            enableBorder = false;
          };
          workspaces = {
            enableBorder = false;
            smartHighlight = true;
            active = "#b4befe";
            occupied = "#62a0ea";
            hover = "#62a0ea";
          };
          windowtitle = {
            enableBorder = false;
          };
          systray = {
            enableBorder = false;
          };
          modules = {
            kbLayout = {
              enableBorder = false;
            };
            netstat = {
              enableBorder = false;
            };
          };
          monochrome = true;
          spacing = "0.50em";
          padding_y = "0.2rem";
          padding_x = "0.7rem";
          opacity = 100;
        };
        outer_spacing = "1em";
        layer = "top";
        margin_top = "1.2em";
        border_radius = "0.4em";
        margin_sides = "0.5em";
        margin_bottom = "0.5em";
        menus = {
          monochrome = true;
          border = {
            radius = "0.7em";
          };
          menu = {
            power = {
              scaling = 100;
            };
            dashboard = {
              profile = {
                radius = "3em";
              };
            };
          };
          card_radius = "0.4em";
        };
        opacity = 100;
        enableShadow = false;
      };
      osd = {
        duration = 2500;
        orientation = "horizontal";
        location = "top right";
        margins = "50px 50px 50px 50px";
        muted_zero = true;
        radius = "0.6em";
      };
      matugen = false;
      matugen_settings = {
        mode = "dark";
      };
    };
    menus = {
      clock = {
        weather = {
          location = "Klaten";
          key = "d62572757403946f6fa5d9702a932d2e";
          unit = "metric";
          enabled = true;
        };
        time = {
          military = false;
          hideSeconds = true;
        };
      };
      dashboard = {
        stats = {
          enable_gpu = false;
        };
        powermenu = {
          avatar = {
            image = "/etc/nixos/themes/pict/.face.jpg";
          };
        };
        shortcuts = {
          left = {
            shortcut1 = {
              icon = "";
              command = "zen";
              tooltip = "Zen-Browser";
            };
            shortcut2 = {
              command = "spotify";
            };
            shortcut4 = {
              command = "rofi-launcher";
            };
          };
          right = {
            shortcut1 = {
              command = "hyprpicker";
            };
            shortcut3 = {
              command = "hyprshot -m output";
            };
          };
        };
        directories = {
          left = {
            directory1 = {
              command = "bash -c \"nemo $HOME/Downloads/\"";
            };
            directory2 = {
              command = "bash -c \"nemo $HOME/Videos/\"";
            };
            directory3 = {
              command = "bash -c \"nemo $HOME/Projects/\"";
            };
          };
          right = {
            directory1 = {
              command = "bash -c \"nemo $HOME/Documents/\"";
            };
            directory2 = {
              command = "bash -c \"nemo $HOME/Pictures/\"";
            };
            directory3 = {
              command = "bash -c \"nemo $HOME/\"";
            };
          };
        };
      };
      volume = {
        raiseMaximumVolume = true;
      };
    };
    bar = {
      customModules = {
        updates = {
          pollingInterval = 1440000;
          icon = "󰏖";
        };
        netstat = {
          networkInterface = "wlan0";
          icon = "󰣺";
          labelType = "full";
          round = true;
        };
        kbLayout = {
          icon = "";
          labelType = "code";
          leftClick = "";
        };
        storage = {
          paths = [ "/" ];
        };
      };
      workspaces = {
        numbered_active_indicator = "underline";
        show_numbered = false;
        show_icons = false;
        hideUnoccupied = false;
        scroll_speed = 5;
        showAllActive = true;
      };
      windowtitle = {
        custom_title = true;
        title_map = [ ];
      };
      systray = {
        label = true;
      };
      volume = {
        label = true;
      };
      bluetooth = {
        label = true;
      };
      media = {
        show_label = true;
        truncation = true;
        show_active_only = true;
      };
      notifications = {
        show_total = false;
      };
      clock = {
        format = "%a %b %d  %I:%M %p";
      };
      launcher = {
        autoDetectIcon = true;
      };
      autoHide = "never";
      border = {
        location = "none";
      };
      opacity = 100;
      buttons = {
        opacity = 100;
      };
      layouts = {
        "0" = {
          left = [ "dashboard" "workspaces" "windowtitle" ];
          middle = [ "media" ];
          right = [ "systray" "volume" "network" "bluetooth" "battery" "clock" "notifications" ];
        };
        "1" = {
          left = [ "dashboard" "workspaces" "windowtitle" ];
          middle = [ "media" ];
          right = [ "systray" "volume" "clock" "notifications" ];
        };
        "2" = {
          left = [ "dashboard" "workspaces" "windowtitle" ];
          middle = [ "media" ];
          right = [ "systray" "volume" "clock" "notifications" ];
        };
      };
    };
    wallpaper = {
      pywal = true;
      image = "~/Pictures/Fuji.jpg";
      enable = true;
    };
    scalingPriority = "gdk";
    notifications = {
      active_monitor = true;
      timeout = 2000;
    };
    tear = true;
  };
}
