# Spicetify is a spotify client customizer
{ pkgs, config, lib, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  # accent = "${config.lib.stylix.colors.base0D}";
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # stylix.targets.spicetify.enable = false;

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    # theme = lib.mkForce spicePkgs.themes.text;

    # colorScheme = "custom";

    # customColorScheme = {
    #   button = accent;
    #   button-active = accent;
    #   tab-active = accent;
    # };

    enabledExtensions = with spicePkgs.extensions; [
      playlistIcons
      lastfm
      historyShortcut
      hidePodcasts
      adblock
      fullAppDisplay
      shuffle
    ];
  };
}
