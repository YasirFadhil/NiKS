{ pkgs, lib, config, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
      name = "kvantum";
    };
  };
}
