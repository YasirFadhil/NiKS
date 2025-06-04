{ config, pkgs, ... }:

{
  # (Optional) Jika ingin explicit, sebenarnya enable programs.nushell akan menginstall juga
  home.packages = with pkgs; [ nushell ];

  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };
}
