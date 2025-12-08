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
    xwayland-satellite

    # Audio/Video
    alsa-utils
    alsa-ucm-conf
    pamixer
    playerctl
    ffmpeg_7


    # Development Tools
    git
    python3
    python3Packages.pip
    clang
    cmake
    gnumake
    just

    # Qt6 Development
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qttools
    qt6.qmake

    # System Monitoring
    btop
    fastfetch
    neofetch

    # Text Editors
    zed-editor
    vim
    neovim
    onlyoffice-desktopeditors

    # AI/ML Tools
    ollama

    # Shells and Shell Utilities
    fish
    zsh
    nushell
    oh-my-zsh
    zsh-syntax-highlighting
    starship

    # GNOME/GTK Tools
    gnome-disk-utility
    adwaita-icon-theme
    gsettings-desktop-schemas
    librsvg
    gtk3
    gtk4
    gtk-layer-shell

    # GTK Themes and Icons
    whitesur-gtk-theme
    whitesur-icon-theme
    bibata-cursors

    # Display Servers & Protocols
    spice-gtk
    wayland-utils
    wayland-protocols
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    xwayland
    xorg.xhost
    xorg.xauth

    # Samba
    samba
    cifs-utils

    # Network
    networkmanagerapplet

    # Qt configuration
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum

    # Screenshot Tools
    grim
    slurp

    # Clipboard
    cliphist

    # System Control
    brightnessctl

    # Python
    (python3.withPackages (ps: [
      ps.requests
      ps.pip
      ps.numpy
    ]))
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.07"
    "python-2.7.18.8"
  ];

  # onlyoffice has trouble with symlinks: https://github.com/ONLYOFFICE/DocumentServer/issues/1859
  system.userActivationScripts = {
    copy-fonts-local-share = {
      text = ''
        rm -rf ~/.local/share/fonts
        mkdir -p ~/.local/share/fonts
        cp ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
        chmod 544 ~/.local/share/fonts
        chmod 444 ~/.local/share/fonts/*
      '';
    };
  };
}
