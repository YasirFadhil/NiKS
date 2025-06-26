{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
	wget
  xfce.thunar
  xfce.tumbler
  xfce.thunar-volman
  nautilus
  adwaita-icon-theme
  gsettings-desktop-schemas
  librsvg
  gvfs
  dconf-editor
  dbus
  gvfs
  udisks
	zed-editor
	fish
	zsh
	nushell
	oh-my-zsh
	zsh-syntax-highlighting
	vim
	neovim
	efibootmgr
	pamixer
	brightnessctl
	noto-fonts
	noto-fonts-emoji
	samba
  mediawriter
  ventoy-full
  python
  ];

  nixpkgs.config.permittedInsecurePackages = [
  "ventoy-1.1.05"
  "python-2.7.18.8"
  ];
}
