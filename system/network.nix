{ config, pkgs, lib, ... }:

{
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  networking.firewall.allowedTCPPorts = [ 80 443 1935 8080 8081 ];
  networking.firewall.allowedUDPPorts = [ 3478 3479 ];

  #KDE connect
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; }
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
