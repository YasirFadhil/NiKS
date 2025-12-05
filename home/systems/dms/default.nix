{ config, lib, pkgs, inputs, ... }:

with lib;

let
  cfg = config.dms;
in
{
  options.dms = {
    enable = mkEnableOption "DankMaterialShell";

    package = mkOption {
      type = types.package;
      default = inputs.dms.packages.${pkgs.system}.default or pkgs.callPackage ./package.nix { inherit inputs; };
      description = "The DankMaterialShell package to use";
    };

    autoStart = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to start DankMaterialShell automatically";
    };

    compositor = mkOption {
      type = types.enum [ "niri" "hyprland" "sway" "labwc" "mangowc" ];
      default = "niri";
      description = "The Wayland compositor to configure for";
    };

    disableConflicting = mkOption {
      type = types.bool;
      default = true;
      description = "Automatically disable conflicting services like waybar, mako, etc.";
    };

    theme = {
      wallpaperPath = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Path to wallpaper for dynamic theming";
      };

      darkMode = mkOption {
        type = types.bool;
        default = true;
        description = "Enable dark mode";
      };
    };

    features = {
      notifications = mkEnableOption "notification center" // { default = true; };
      launcher = mkEnableOption "application launcher" // { default = true; };
      controlCenter = mkEnableOption "control center" // { default = true; };
      lockScreen = mkEnableOption "lock screen" // { default = true; };
      sessionManagement = mkEnableOption "session management" // { default = true; };
      replaceWaybar = mkEnableOption "replace waybar with DMS panels" // { default = true; };
    };

    keybinds = mkOption {
      type = types.attrsOf types.str;
      default = {
        launcher = "Mod+D";
        controlCenter = "Mod+Shift+C";
        notifications = "Mod+N";
        lockScreen = "Mod+Shift+L";
      };
      description = "Key bindings for DMS functions";
    };
  };

  config = mkIf cfg.enable {
    # Conditionally import DMS home-manager module if available
    imports = optionals (hasAttr "homeModules" inputs.dms && hasAttr "dankMaterialShell" inputs.dms.homeModules)
      [ inputs.dms.homeModules.dankMaterialShell.default ];

    # Disable conflicting services
    programs.waybar.enable = mkIf (cfg.disableConflicting && cfg.features.replaceWaybar) (mkForce false);

    # Enable DankMaterialShell (fallback configuration if module not available)
    programs.dankMaterialShell = mkIf (hasAttr "homeModules" inputs.dms) {
      enable = true;
      package = cfg.package;

      settings = {
        compositor = cfg.compositor;
        theme = {
          darkMode = cfg.theme.darkMode;
        } // optionalAttrs (cfg.theme.wallpaperPath != null) {
          wallpaperPath = cfg.theme.wallpaperPath;
        };

        features = cfg.features;
        keybinds = cfg.keybinds;
      };
    };

    # Add DankMaterialShell to session path
    home.sessionPath = [ "${cfg.package}/bin" ];

    # Session variables for DankMaterialShell
    home.sessionVariables = {
      DMS_COMPOSITOR = cfg.compositor;
      DMS_CONFIG_DIR = "${config.xdg.configHome}/dms";
      DMS_DATA_DIR = "${config.xdg.dataHome}/dms";
    };

    # Create config directories
    xdg.configFile."dms/.keep".text = "";
    xdg.dataFile."dms/.keep".text = "";

    # Auto-start DankMaterialShell if enabled
    systemd.user.services.dankMaterialShell = mkIf cfg.autoStart {
      Unit = {
        Description = "DankMaterialShell Desktop Shell";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
      };

      Service = {
        Type = "notify";
        ExecStart = "${cfg.package}/bin/dms run";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR1 $MAINPID";
        Restart = "on-failure";
        RestartSec = 3;
        TimeoutStartSec = 30;
        TimeoutStopSec = 10;
        KillMode = "mixed";

        # Environment variables
        Environment = [
          "XDG_CURRENT_DESKTOP=DankMaterialShell"
          "XDG_SESSION_DESKTOP=DankMaterialShell"
          "DMS_COMPOSITOR=${cfg.compositor}"
          "WAYLAND_DISPLAY=${config.home.sessionVariables.WAYLAND_DISPLAY or "wayland-1"}"
        ];
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };

    # Niri integration - add DMS keybinds to niri config
    programs.niri.settings = mkIf (cfg.compositor == "niri" && config.programs.niri.enable) {
      binds = {
        "${cfg.keybinds.launcher}".action.spawn = ["dms" "ipc" "call" "spotlight" "toggle"];
        "${cfg.keybinds.controlCenter}".action.spawn = ["dms" "ipc" "call" "controlcenter" "toggle"];
        "${cfg.keybinds.notifications}".action.spawn = ["dms" "ipc" "call" "notifications" "toggle"];
        "${cfg.keybinds.lockScreen}".action.spawn = ["dms" "lock"];
      };

      # Add DMS to niri startup
      spawn-at-startup = mkIf cfg.autoStart [
        { command = ["systemctl" "--user" "start" "dankMaterialShell.service"]; }
      ];
    };

    # Required dependencies
    home.packages = with pkgs; [
      # Core dependencies that DMS needs
      quickshell
      playerctl
      pamixer
      brightnessctl
      networkmanager
      bluez

      # DMS package
      cfg.package

      # Optional but recommended
      matugen  # For dynamic theming
      imagemagick  # For wallpaper processing
      jq  # For JSON processing in scripts
      wl-clipboard  # Clipboard support
      grim  # Screenshots
      slurp  # Screen selection

      # Font dependencies
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      material-design-icons
    ];

    # Font configuration
    fonts.fontconfig.enable = true;

    # Enable services that DMS integrates with
    services = mkIf cfg.disableConflicting {
      # Notification daemon (DMS replaces mako/dunst)
      mako.enable = mkForce false;
      dunst.enable = mkForce false;
      swaync.enable = mkForce false;

      # Disable other panels/bars if DMS is handling them
      waybar.enable = mkIf cfg.features.replaceWaybar (mkForce false);

      # Keep these services as DMS integrates with them
      network-manager-applet.enable = mkDefault false; # DMS handles this
      blueman-applet.enable = mkDefault false; # DMS handles this
    };

    # GTK and Qt theming integration
    gtk = {
      enable = true;
      theme = mkDefault {
        name = "WhiteSur-Dark";
        package = pkgs.whitesur-gtk-theme;
      };
      iconTheme = mkDefault {
        name = "WhiteSur-dark";
        package = pkgs.whitesur-icon-theme;
      };
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
      style = {
        name = "gtk2";
        package = pkgs.qt5.qtbase;
      };
    };

    # Additional XDG portal configuration for DMS
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    # Create a simple DMS package if the flake input doesn't provide one
    nixpkgs.config.packageOverrides = pkgs: {
      dms-simple = pkgs.writeShellScriptBin "dms" ''
        #!/bin/bash
        echo "DankMaterialShell wrapper script"
        echo "To install the full version, ensure the DMS flake input is properly configured"
        case "$1" in
          "run")
            echo "Starting DankMaterialShell..."
            exec quickshell -p ${./quickshell-config} "$@"
            ;;
          "ipc")
            echo "IPC command: $*"
            ;;
          *)
            echo "Usage: dms {run|ipc|...}"
            ;;
        esac
      '';
    };
  };
}
