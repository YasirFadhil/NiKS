{ pkgs, lib, config, ... }:

{
  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
      name = "kvantum";
    };
  };
}
