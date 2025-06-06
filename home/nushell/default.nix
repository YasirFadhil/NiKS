{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ nushell ];

  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };
}
