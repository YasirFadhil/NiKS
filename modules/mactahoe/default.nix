{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.mactahoe;
in
{
  options.modules.mactahoe = {
    enable = mkEnableOption "Enable MacTahoe icon theme";

    package = mkOption {
      type = types.package;
      default = pkgs.callPackage ../../tahoe/flake.nix { };
      description = "The MacTahoe icon theme package";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    gtk = {
      iconTheme = {
        name = "MacTahoe";
        package = cfg.package;
      };
    };

    home.sessionVariables = {
      GTK_ICON_THEME = "MacTahoe";
      ICON_THEME = "MacTahoe";
    };
  };
}
