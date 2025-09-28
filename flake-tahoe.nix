{
  description = "MacTahoe icon theme flake for NixOS";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.mactahoe = pkgs.stdenv.mkDerivation {
        pname = "MacTahoe-icon-theme";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "vinceliuice";
          repo = "MacTahoe-icon-theme";
          rev = "master";
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Ganti dengan hasil nix-prefetch
        };

        installPhase = ''
          mkdir -p $out/share/icons
          cp -r MacTahoe $out/share/icons/
        '';
      };
    };
}