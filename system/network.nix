{ config, pkgs, lib, ... }:

{
  networking.networkmanager.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;
  # programs.kdeconnect.enable = true;
  # Firewall
     networking.firewall = {
       enable = true;
       allowedTCPPorts = [80 443 1935 3000 8080 8081 9000];
       allowedUDPPorts = [3478 3479];
       allowedTCPPortRanges = [
         { from = 1714; to = 1764; }
       ];
       allowedUDPPortRanges = [
         { from = 1714; to = 1764; }
       ];
     };
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
