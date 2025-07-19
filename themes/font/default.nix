{ pkgs, inputs, ... }: {
  fonts.packages = with pkgs; [
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro
    inputs.apple-fonts.packages.${pkgs.system}.sf-mono
    # inputs.apple-fonts.packages.${pkgs.system}.new-york
  ];
}
