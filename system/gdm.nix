{ config, pkgs, lib, ... }:

{
  # Enable GDM as display manager
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
    autoSuspend = false;

    # GDM settings customization
    settings = {
      greeter = {
        # Include all users in greeter
        IncludeAll = true;
        # Uncomment to disable user list
        # DisableUserList = true;
        # Show manual login option
        ShowManualLogin = true;
        # Banner message (optional)
        # Banner = "Welcome to NixOS";
      };

      security = {
        # Disable TCP connections for security
        DisallowTCP = true;
        # Disable root login
        AllowRoot = false;
      };

      xdmcp = {
        # Disable XDMCP
        Enable = false;
      };

      daemon = {
        # Automatic login settings (uncomment and modify as needed)
        # AutomaticLoginEnable = true;
        # AutomaticLogin = "username";
        # TimedLoginEnable = true;
        # TimedLogin = "username";
        # TimedLoginDelay = 10;

        # Wayland settings
        WaylandEnable = true;
        # Force Wayland (uncomment if needed)
        # DefaultSession = "gnome-wayland";
      };
    };
  };

  # GDM theme customization
  environment.systemPackages = with pkgs; [
    # Add custom GDM themes if needed
    # gnome-themes-extra
  ];

  # Custom GDM CSS (optional)
  # Uncomment and modify if you want custom styling
  # environment.etc."gdm/custom.conf".text = ''
  #   [daemon]
  #   WaylandEnable=true
  #
  #   [security]
  #   DisallowTCP=true
  #   AllowRoot=false
  #
  #   [xdmcp]
  #   Enable=false
  #
  #   [greeter]
  #   IncludeAll=true
  # '';

  # GDM 3 specific customizations
  programs.dconf.profiles.gdm.databases = [{
    settings = {
      # Login screen background
      "org/gnome/desktop/background" = {
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
        primary-color = "#241f31";
        secondary-color = "#000000";
      };

      # Interface settings
      "org/gnome/desktop/interface" = {
        cursor-theme = "Adwaita";
        font-name = "Cantarell 11";
        icon-theme = "Adwaita";
        gtk-theme = "Adwaita";
        # Enable dark theme for login screen
        color-scheme = "prefer-dark";
      };

      # Sound settings
      "org/gnome/desktop/sound" = {
        event-sounds = true;
        theme-name = "freedesktop";
      };

      # Privacy settings
      "org/gnome/desktop/privacy" = {
        disable-microphone = false;
        disable-camera = false;
      };

      # Power settings for login screen
      "org/gnome/settings-daemon/plugins/power" = {
        power-button-action = "interactive";
        sleep-inactive-ac-timeout = 0;
        sleep-inactive-battery-timeout = 0;
      };
    };
  }];

  # Additional GDM-related services
  services.gnome.gnome-keyring.enable = true;
  services.accounts-daemon.enable = true;

  # Optional: Custom login screen logo
  # Uncomment and set path to your logo
  # services.xserver.displayManager.gdm.banner = "Welcome to NixOS";

  # Optional: Auto login configuration
  # Uncomment and modify as needed
  # services.xserver.displayManager.autoLogin = {
  #   enable = true;
  #   user = "username";
  # };

  # Ensure proper permissions for GDM
  users.groups.gdm = {};
  users.users.gdm = {
    group = "gdm";
    home = "/var/lib/gdm";
    createHome = true;
    isSystemUser = true;
    shell = pkgs.bash;
  };
}
