{ config, pkgs, lib, ... }:

{
  # GDM is disabled - using tuigreet instead
  services.displayManager.gdm.enable = false;
}
