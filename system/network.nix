{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;

  # Allow KDE Connect port range
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; }
  ];
}
