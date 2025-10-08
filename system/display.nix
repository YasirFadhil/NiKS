{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  # services.displayManager.ly.enable = true;
  services.desktopManager.gnome.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Additional GNOME optimization (optional)
  environment.gnome.excludePackages = with pkgs; [
    # Remove if you want to keep these
    gnome-tour
    epiphany
    geary
    evince
  ];
  services.gvfs.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    model = "chromebook";
  };
}
