{
  description = "A flake for the MacTahoe icon theme";

  # Input untuk flake ini hanya nixpkgs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  # Outputnya bukan sistem NixOS, tapi sebuah overlay
  outputs = { self, nixpkgs }: {
    # Menyediakan overlay yang bisa digunakan oleh flake lain
    overlays.default = final: prev: {
      mac-tahoe-icon-theme = prev.stdenv.mkDerivation rec {
        pname = "mac-tahoe-icon-theme";
        version = "2023-09-15";

        src = prev.fetchFromGitHub {
          owner = "vinceliuice";
          repo = "MacTahoe-icon-theme";
          rev = "ab924e2079da7cd038083815b3c5332f22b70f07";
          sha256 = "sha256-43d7YhTzVn7T92Wl0lYc3038wN1h46cI51bB8R7j42Y=";
        };

        nativeBuildInputs = [ prev.bash prev.git ];

        buildPhase = ''
          runHook preBuild
          chmod +x install.sh
          ./install.sh -d $out/share/icons -n MacTahoe
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          # Kosong
          runHook postInstall
        '';

        meta = with prev.lib; {
          description = "MacTahoe icon theme, a macOS-like icon theme for Linux desktops";
          homepage = "https://github.com/vinceliuice/MacTahoe-icon-theme";
          license = licenses.gpl3Only;
          platforms = platforms.all;
        };
      };
    };
  };
}
