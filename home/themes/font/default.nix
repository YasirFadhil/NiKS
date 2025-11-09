{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    inter               # Similar to SF Pro
    jetbrains-mono      # Great monospace font
    noto-fonts          # Comprehensive font family
    noto-fonts-cjk-sans # CJK support
    ubuntu-classic  # Clean, modern font
  ];
}
