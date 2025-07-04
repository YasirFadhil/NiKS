{ pkgs, ... }:

  with pkgs; [
   git
   kitty
   starship
   discord
   pavucontrol
   clang
   zig
   alsa-utils
   alsa-ucm-conf
   fastfetch
   ghostty
  # gnome-tweaks
  # gnome-extension-manager
   google-chrome
   carapace
   zoxide
   btop
   # python2
   #cope
   #python311Packages.pip
   #python312Packages.pip
   #python313Packages.pip
   # spotify
   hyprpaper
   hyprpolkitagent
   rofi-wayland
   blueman
   waybar
   adw-gtk3
   whitesur-gtk-theme
   qt5.qtwayland
   qt6.qtwayland
   libsForQt5.qt5ct
   qt6ct
   hyprshot
   hyprpicker
   gtk3
   gtk4
   gtk-layer-shell
   go
   wlogout
   hyprlock
   hypridle
   wayland-utils
   wayland-protocols
   waypaper
   # swaynotificationcenter
   nerd-fonts.fira-code
   nerd-fonts.jetbrains-mono
   cliphist
   wlr-randr
   wl-clipboard
   #dunst
   rofi-emoji-wayland
   kdePackages.gwenview
   # kdePackages.kdeconnect-kde
   hyprshot
   swappy
   grim
   slurp
   playerctl
   spicetify-cli
   cifs-utils
   fuzzel
   wev
   cava
   brightnessctl
   pamixer
   gimp3
   upower
   polkit_gnome
   gnome-keyring
   libcanberra-gtk3
   libreoffice
   corefonts
   cmatrix
   cbonsai
   neofetch
   nwg-dock-hyprland
   vscode
   swww
  ]
