  { pkgs, lib, config, ... }:

  {
    qt = {
      enable = true;
      platformTheme.name = "gtk";
    };
  }
