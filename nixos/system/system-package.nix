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

    # Development Tools
    git
    python3
    python3Packages.pip
    clang

    # System Monitoring
    btop
    fastfetch
    neofetch

    # Text Editors
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
    xwayland
    xorg.xhost
    xorg.xauth

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
