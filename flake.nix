{
  description = "My NixOS Flake Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    pkgs.follows = "nixpkgs";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    stylix.url = "github:danth/stylix";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    zen-browser.url = "git+https://git.sr.ht/~canasta/zen-browser-flake/";
    # spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix = {
          url = "github:Gerg-L/spicetify-nix";
          inputs.nixpkgs.follows = "nixpkgs";
        };
     hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, pkgs, zen-browser, home-manager, hyprland, hyprpanel, stylix, apple-fonts, spicetify-nix }: let
    system = "x86_64-linux";
    overlays = [
            hyprpanel.overlay
       ];
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.default
        stylix.nixosModules.stylix
        {
        nix.settings = {
            substituters = ["https://hyprland.cachix.org"];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
          };
        }
        {
          nixpkgs.overlays = overlays;
        }
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hmbackup";
          home-manager.users.yasirfadhil = import ./home/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }

        ({ pkgs, ... }: {
          programs.hyprland = {
            enable = true;
            package = pkgs.hyprland;
            portalPackage = pkgs.xdg-desktop-portal-hyprland;
          };
        })
      ];
      # _module.args = {inherit inputs;};
      specialArgs = {
        inherit inputs home-manager zen-browser hyprland;
      };
    };

    devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
      buildInputs = [ nixpkgs.legacyPackages.${system}.nodejs ];
    };
  };
}
