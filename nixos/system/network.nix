{ config, pkgs, lib, ... }:

{
  networking.networkmanager.enable = true;
  programs.localsend.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  # Firewall
     networking.firewall = {
       enable = true;
       allowedTCPPorts = [80 443 1935 3000 8080 8081 8292 9000];
       allowedUDPPorts = [3478 3479 5678];
       allowedTCPPortRanges = [
         { from = 1714; to = 1764; }
       ];
       allowedUDPPortRanges = [
         { from = 1714; to = 1764; }
       ];
     };
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  networking.hosts = {
      "127.0.0.1" = ["localhost"];
      "192.168.122.128" = ["damurdamm.test"];
      "10.60.149.102" = ["damurdamm.test"];
      "172.16.57.129" = ["damurdamm.test"];
      "172.16.193.2" = ["damurdamm.test"];
    };
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
