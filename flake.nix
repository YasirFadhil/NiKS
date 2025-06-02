{
  description = "My NixOS Flake Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    pkgs.follows = "nixpkgs";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, pkgs, home-manager, zen-browser, hyprland, hyprpanel }: let
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
        inherit home-manager zen-browser hyprland;
      };
    };

    # Firewall
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [80 443 3000 9000];
      allowedUDPPortRanges = [
        {
          from = 40000;
          to = 50000;
        }
      ];
    };

      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
      buildInputs = [ nixpkgs.legacyPackages.${system}.nodejs ];
    };
  };
}
