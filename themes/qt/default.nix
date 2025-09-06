  { pkgs, lib, config, ... }:

  {
    qt = {
      enable = true;
      platformTheme.name = "qt5ct";
      style.name = "kvantum";
    };
  }
