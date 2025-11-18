{ pkgs, ... }:

with pkgs; [
  # Custom scripts
  (import ./scripts/volume.nix { inherit pkgs; })
  (import ./scripts/launcher.nix { inherit pkgs; })
  (import ./scripts/clipboard.nix { inherit pkgs; })
  (import ./scripts/swaylock-blur.nix { inherit pkgs; })

  # Terminal Emulators
  kitty
  ghostty

  # Shell Tools
  carapace
  zoxide
  cmatrix
  cbonsai
  neofetch
  cava
  scrcpy

  # Development
  zig
  go
  nodejs
  vscode

  # Browsers and Communication
  google-chrome
  discord
  kdePackages.kdeconnect-kde

  # System Tools
  putty
  winbox4

  # Media and Entertainment
  vlc
  obs-studio
  pavucontrol

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
  waypaper
  wlogout
  waybar
  wlr-randr
  wl-clipboard
  swww
  swayidle

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

  # Screenshot Tools
  grim
  slurp

  # Clipboard
  cliphist

  # System Control
  brightnessctl
]
