{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    udisks
    gnome-disk-utility
    adwaita-icon-theme
    gsettings-desktop-schemas
    librsvg
    gvfs
    dconf-editor
    dbus
    spice-gtk
    efibootmgr
    pamixer
    brightnessctl
    mediawriter
    ventoy-full
    python
    # Text editors
    zed-editor
    vim
    neovim
    # Shells
    fish
    zsh
    nushell
    oh-my-zsh
    zsh-syntax-highlighting
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.07"
    "python-2.7.18.8"
  ];
}
