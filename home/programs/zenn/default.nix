{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [inputs.zen-browser.packages."${stndev.hostPlatform.system}".default];
}
