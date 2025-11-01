{ pkgs, ... }:{

  imports = [
    ./starship.nix
  ];

  programs.nushell = {
    enable = true;
      configFile.source = ./config.nu;
      envFile.source = ./env.nu;
  };
  programs.starship.enable = true;
}
