{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    samba
    cifs-utils
  ];

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "client min protocol" = "NT1";
        "client max protocol" = "SMB3";
        "workgroup" = "WORKGROUP";
        "security" = "user";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lock/samba 0755 root root -"
    "d /var/lib/samba 0755 root root -"
    "d /var/cache/samba 0755 root root -"
    "d /var/run/samba 0755 root root -"
  ];

  fileSystems."/mnt/samba" = {
    device = "//192.168.1.1/samba";
    fsType = "cifs";
    options = [
      "guest"
      "vers=1.0"
      "nosetuids"
      "noperm"
      "uid=1000"  # Replace with your user ID (run `id -u`)
      "gid=100"   # Replace with your group ID (run `id -g`)
    ];
  };
}
