{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Core fonts
    inter               # Similar to SF Pro
    jetbrains-mono      # Great monospace font
    noto-fonts          # Comprehensive font family
    noto-fonts-color-emoji # Emoji support
    noto-fonts-cjk-sans # CJK support
    ubuntu-classic      # Clean, modern font

    # Icon fonts
    font-awesome        # Icon font

    # Nerd Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    # System fonts
    corefonts           # Microsoft core fonts
  ];

  fonts.fontconfig.enable = true;
}
