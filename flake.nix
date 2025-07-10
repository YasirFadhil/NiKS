{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    pkgs.follows = "nixpkgs";
    zen-browser.url = "git+https://git.sr.ht/~canasta/zen-browser-flake/";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
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

  outputs = inputs @ { self, nixpkgs, pkgs, zen-browser, home-manager, apple-fonts, spicetify-nix, hyprland, hyprpanel }: let
    system = "x86_64-linux";
    # overlays = [
    #        hyprpanel.overlay
    #   ];
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.default
        {
        nix.settings = {
            substituters = ["https://hyprland.cachix.org"];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
          };
        }
        # {
        #   nixpkgs.overlays = overlays;
        # }
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
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
      specialArgs = {
        inherit inputs;
      };
    };

    # (optional) keep your packages if you want
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  };
}
