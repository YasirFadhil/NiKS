{ config, pkgs, ... }:

{

  home.username = "yasirfadhil";
  home.homeDirectory = "/home/yasirfadhil";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    xfce.thunar
    xfce.tumbler
    kitty
    pavucontrol
    git
    clang
    zig
    alsa-utils
    alsa-ucm-conf
    fastfetch
    ghostty
    gnome-tweaks
    google-chrome
    carapace
    zoxide
    spotify
    hyprpaper
    rofi-wayland
    networkmanagerapplet
    blueman
    waybar
    adw-gtk3
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6ct
    hyprshot
    hyprpicker
    gtk3
    gtk4
    wlogout
    hyprlock
    hypridle
    wayland-utils
    wayland-protocols
    swaynotificationcenter
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    cliphist
    wlr-randr
    wl-clipboard
    hyprpanel
    dunst
    kdePackages.gwenview
    kdePackages.kdeconnect-kde
    hyprshot
    swappy
    grim
    slurp
    playerctl
    spicetify-cli
    cifs-utils
    fuzzel
  ];

  programs.nushell.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.firefox.enable = true;
  # programs.kdeconnect = {
  #   enable = true;
  #   openFirewall = true;
  #   # package = pkgs.kdePackages.kdeconnect-kde;
  # };


  # Firewall
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [80 443 3000 9000];
  #   allowedUDPPortRanges = [
  #     {
  #       from = 40000;
  #       to = 50000;
  #     }
  #   ];
  # };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };

  # programs.waybar = {
  #   enable = true;
  # };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [",eDP-1,1700x950@60,0x0,1"];
      exec-once = [
        # "waybar &"
        # "${hyprpanel}/bin/hyprpanel"
        "hyprpanel &"
        "hypridle &"
        # "swaynotificationcenter &"
        "hyprpaper &"
        # "nm-applet &"
        # "blueman-applet &"
        "hyprctl setcursor Bibata-Modern-Ice 20"
      ];
      input = {
        kb_model = "chromebook";
        kb_layout = "us";
        touchpad = {
          natural_scroll = true;
        };
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        col.active_border = "rgba(33ccffee)";
        col.inactive_border = "rgba(595959aa)";
      };
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
        };
      };
      animations = {
        enabled = true;
        bezier = [ "myBezier,0.05,0.9,0.1,1.05" ];
        animation = [ "windows,1,7,myBezier" ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
      # bindl = [
        #Volume & brightness
        #"XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_SINK@ 5%+"
        # "XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_SINK@ 5%-"
        # "XF86AudioMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
        # "XF86MonBrightnessUp, exec, brightnessctl s +5%"
        # "XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      # ];

      bindl = "XF86AudioRaiseVolume, exec, pamixer -i 5";

      bind = [
        #basic
        "SUPER, T, exec, kitty"
        "SUPER, B, exec, zen-browser"
        "SUPER, F, exec, thunar"
        "SUPER CTRL, V, exec, pavucontrol"
        "SUPER, D, exec, ~/Downloads/launcher.sh"
        "SUPER, X, fullscreen"
        "SUPER, Q, killactive"
        "SUPER, ESCAPE, exit"
        "SUPER, P, exec, wlogout"
        "SUPER, L, exec, hyprlock"
        "SUPER SHIFT, V, exec, wl-clipboard"

        #screenshot
        "SUPER, S, exec, grim - | tee ~/Pictures/Screenshots/screenshot_$(date +%s).png | wl-copy"
        "SUPER SHIFT, S, exec, grim -g $(slurp) - | swappy -f -"

        # Move focus
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        # Move window
        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, J, movewindow, d"

        # Workspace switching
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        # Move window to workspace
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  fonts.fontconfig.enable = true;
  home.stateVersion = "24.05";
}
