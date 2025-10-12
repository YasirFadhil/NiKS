{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # System Utilities
    wget
    udisks
    efibootmgr
    dbus
    gvfs
    mediawriter
    ventoy-full
    net-tools
    polkit_gnome
    gnome-keyring
    upower

    # Audio/Video
    alsa-utils
    alsa-ucm-conf
    pamixer
    playerctl

    # Development Tools
    git
    python3
    python3Packages.pip
    clang

    # System Monitoring
    btop
    fastfetch

    # Text Editors
    zed-editor
    vim
    neovim

    # Shells and Shell Utilities
    fish
    zsh
    nushell
    oh-my-zsh
    zsh-syntax-highlighting
    starship

    # GNOME/GTK Tools
    gnome-disk-utility
    dconf-editor
    adwaita-icon-theme
    gsettings-desktop-schemas
    librsvg
    gtk3
    gtk4
    gtk-layer-shell

    # Display Servers & Protocols
    spice-gtk
    wayland-utils
    wayland-protocols
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # Qt Libraries
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6ct
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.07"
    "python-2.7.18.8"
  ];
}
