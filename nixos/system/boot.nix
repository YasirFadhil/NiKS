{ config, pkgs, inputs, ... }:

{
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.plymouth = {
    enable = false;
    # theme = "mac-style";
    # themePackages = [
      # inputs.mac-style-plymouth.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ];
  };

  boot.consoleLogLevel = 4;
  boot.initrd = {
    kernelModules = [ "i915" ];
    verbose = true;
    systemd = {
      enable = false;
    };
  };
  boot.kernelParams = [
    # "quiet"
    # "splash"
    # "boot.shell_on_fail"
    # "loglevel=3"
    # "rd.systemd.show_status=false"
    # "rd.udev.log_priority=3"
    # "udev.log_priority=3"
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
