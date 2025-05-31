{ config, pkgs, ... }:

{
  # Pastikan nushell sudah ada di packages
  home.packages = with pkgs; [ nushell ];

  # Deploy config.nu dan env.nu ke folder Nushell
  home.file.".config/nushell/config.nu".source = ./config.nu;
  home.file.".config/nushell/env.nu".source = ./env.nu;
}
