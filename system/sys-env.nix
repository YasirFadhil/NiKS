{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
	wget
  xfce.thunar
  xfce.tumbler
  xfce.thunar-volman
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
  samba
  mediawriter
  ventoy-full
  ];
  
  nixpkgs.config.permittedInsecurePackages = [
  "ventoy-1.1.05"
  ];
}


