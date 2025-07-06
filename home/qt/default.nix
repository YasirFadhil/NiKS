  { pkgs, lib, config, ... }:

  {
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      # font = {
      #   name = "Fira Code Nerd Font";
      #   size = 12;
      # };
    };
  }
