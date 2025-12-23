{ pkgs, ... }:

with pkgs; [
  # Custom scripts
  (import ./scripts/volume.nix { inherit pkgs; })
  (import ./scripts/launcher.nix { inherit pkgs; })
  (import ./scripts/clipboard.nix { inherit pkgs; })
  (import ./scripts/swaylock-blur.nix { inherit pkgs; })
  (import ./scripts/swaync-shot.nix { inherit pkgs; })
  (import ./scripts/battery.nix { inherit pkgs; })
  (import ./scripts/nowplay.nix { inherit pkgs; })
  (import ./scripts/audio-sink.nix { inherit pkgs; })
  (import ./scripts/battery-monitor.nix { inherit pkgs; })

  # Terminal Emulators
  kitty
  ghostty
  alacritty
  foot

  # Shell Tools
  carapace
  zoxide
  cmatrix
  cbonsai
  cava
  scrcpy
  quickshell
  libnotify

  # Development
  zig
  go
  nodejs
  zed
  python3Packages.pylsp-mypy
  python3Packages.python-lsp-server
  python3Packages.pyflakes

  # Browsers and Communication
  google-chrome
  microsoft-edge
  discord
  kdePackages.kdeconnect-kde

  # System Tools
  putty
  winbox4
  ulauncher
  cloudflare-warp
  swaybg

  # Media and Entertainment
  vlc
  obs-studio
  pavucontrol
  sound-theme-freedesktop

  # File Management and Viewers
  kdePackages.gwenview
  libreoffice
  gimp3
  swappy

  # Hyprland and Wayland
  hyprpaper
  hyprpolkitagent
  hyprshot
  hyprpicker
  hyprlock
  hypridle
  wlogout
  waybar
  wlr-randr
  wlopm
  wl-clipboard
  swww
  swayidle
  swaylock-effects

  # Rofi and Related
  rofi
  rofimoji
  rofi-emoji

  # System Tray and Notifications
  swaynotificationcenter
  nwg-dock-hyprland
  blueman
  bluetuith
  networkmanager
  caffeine-ng

  # GTK Themes and Tools
  whitesur-gtk-theme
  adw-gtk3
  whitesur-icon-theme
  bibata-cursors
  gnome-tweaks
  gnome-extension-manager

  # Qt5 and Qt6 theme tools
  libsForQt5.qt5ct
  qt6Packages.qt6ct
  libsForQt5.qtstyleplugin-kvantum
  libsForQt5.qtstyleplugins
  libsForQt5.qtquickcontrols2
  libsForQt5.qtgraphicaleffects

  # Qt Wayland Support
  qt5.qtwayland
  qt6.qtwayland

  # KDE/Breeze Themes
  kdePackages.breeze
  kdePackages.breeze-icons
  kdePackages.breeze-gtk

  # Additional Qt Libraries
  libsForQt5.qtbase

  # Theme utilities
  dconf-editor
]
