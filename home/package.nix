{ pkgs, ... }:

with pkgs; [
  # Custom launchers
  (import ./programs/rofi-launch/launcher.nix { inherit pkgs; })
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

  # Theming and Appearance
  adw-gtk3
  whitesur-gtk-theme
  bibata-cursors
  libcanberra-gtk3

  # GNOME Tools
  gnome-tweaks
  gnome-extension-manager

  # Rofi and Related
  rofi
  rofimoji
  rofi-emoji

  # System Tray and Notifications
  swaynotificationcenter
  nwg-dock-hyprland
  blueman
  caffeine-ng

  # Screenshot Tools
  grim
  slurp

  # Clipboard
  cliphist

  # Fonts
  noto-fonts
  noto-fonts-color-emoji
  nerd-fonts.fira-code
  nerd-fonts.jetbrains-mono
  corefonts

  # System Control
  brightnessctl
]
