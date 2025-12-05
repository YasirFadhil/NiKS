{ pkgs, lib, inputs ? {} }:

let
  # Check if DMS flake provides packages
  dmsPackage = if (inputs ? dms && inputs.dms ? packages && inputs.dms.packages ? ${pkgs.system})
    then inputs.dms.packages.${pkgs.system}.default
    else null;

  # Fallback package if DMS flake is not available
  dmsFallback = pkgs.stdenv.mkDerivation rec {
    pname = "dank-material-shell-fallback";
    version = "0.6.2";

    src = pkgs.fetchFromGitHub {
      owner = "AvengeMedia";
      repo = "DankMaterialShell";
      rev = "v${version}";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # This will need to be updated
    };

    nativeBuildInputs = with pkgs; [
      go
      pkg-config
      wrapQtAppsHook
    ];

    buildInputs = with pkgs; [
      qt6.qtbase
      qt6.qtdeclarative
      qt6.qtsvg
      qt6.qtwayland
      quickshell
      playerctl
      pamixer
      brightnessctl
    ];

    buildPhase = ''
      runHook preBuild

      # Build the Go backend
      cd core
      export GOPATH=$TMPDIR/go
      export GOCACHE=$TMPDIR/go-cache
      export CGO_ENABLED=1

      go mod download
      go build -o ../dms ./cmd/dms
      go build -o ../dankinstall ./cmd/dankinstall

      cd ..

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      mkdir -p $out/share/dms

      # Install binaries
      cp dms $out/bin/
      cp dankinstall $out/bin/

      # Install quickshell configuration
      cp -r quickshell $out/share/dms/

      # Install assets
      cp -r assets $out/share/dms/

      # Create wrapper script
      cat > $out/bin/dms-wrapped << 'EOF'
      #!/bin/bash
      export DMS_DATA_DIR="$XDG_DATA_HOME/dms"
      export DMS_CONFIG_DIR="$XDG_CONFIG_HOME/dms"

      # Ensure config directories exist
      mkdir -p "$DMS_DATA_DIR" "$DMS_CONFIG_DIR"

      # Copy default config if it doesn't exist
      if [ ! -f "$DMS_CONFIG_DIR/config.json" ]; then
        cp -r ${placeholder "out"}/share/dms/quickshell/* "$DMS_CONFIG_DIR/"
      fi

      exec ${placeholder "out"}/bin/dms "$@"
      EOF

      chmod +x $out/bin/dms-wrapped

      runHook postInstall
    '';

    meta = with lib; {
      description = "Desktop shell for wayland compositors built with Quickshell & GO";
      homepage = "https://github.com/AvengeMedia/DankMaterialShell";
      license = licenses.mit;
      platforms = platforms.linux;
      maintainers = [ ];
    };
  };

  # Simple wrapper script for when full build is not available
  dmsSimple = pkgs.writeShellApplication {
    name = "dms";
    runtimeInputs = with pkgs; [
      quickshell
      playerctl
      pamixer
      brightnessctl
      networkmanager
      bluez
      jq
      wl-clipboard
      grim
      slurp
    ];

    text = ''
      #!/bin/bash

      DMS_CONFIG_DIR="''${XDG_CONFIG_HOME:-$HOME/.config}/dms"
      DMS_DATA_DIR="''${XDG_DATA_HOME:-$HOME/.local/share}/dms"

      # Ensure directories exist
      mkdir -p "$DMS_CONFIG_DIR" "$DMS_DATA_DIR"

      case "''${1:-run}" in
        "run")
          echo "Starting DankMaterialShell (simple mode)..."
          echo "Note: Full DMS features require the complete flake installation"

          # Create a minimal quickshell config if it doesn't exist
          if [ ! -f "$DMS_CONFIG_DIR/main.qml" ]; then
            cat > "$DMS_CONFIG_DIR/main.qml" << 'QMLEOF'
      import QtQuick
      import Quickshell

      ShellRoot {
          PanelWindow {
              id: panel
              anchors {
                  left: true
                  right: true
                  top: true
              }
              height: 32

              Rectangle {
                  anchors.fill: parent
                  color: "#1e1e1e"

                  Text {
                      anchors.centerIn: parent
                      text: "DankMaterialShell (Simple Mode) - Install full version for complete features"
                      color: "white"
                  }
              }
          }
      }
      QMLEOF
          fi

          exec quickshell -p "$DMS_CONFIG_DIR"
          ;;
        "ipc")
          shift
          echo "DMS IPC: $*"
          # Simple IPC handling
          case "$1" in
            "call")
              echo "IPC call: $2 $3"
              ;;
            *)
              echo "Unknown IPC command: $1"
              ;;
          esac
          ;;
        "lock")
          echo "Lock screen requested"
          if command -v hyprlock >/dev/null 2>&1; then
            exec hyprlock
          elif command -v swaylock >/dev/null 2>&1; then
            exec swaylock
          else
            echo "No lock screen available"
          fi
          ;;
        "brightness")
          shift
          exec brightnessctl "$@"
          ;;
        "plugins")
          echo "Plugin management not available in simple mode"
          ;;
        *)
          echo "DankMaterialShell Simple Mode"
          echo "Commands:"
          echo "  run              - Start the shell"
          echo "  ipc call <args>  - IPC communication"
          echo "  lock             - Lock screen"
          echo "  brightness <args> - Control brightness"
          echo ""
          echo "Note: Install the full DMS flake for complete functionality"
          ;;
      esac
    '';
  };

in
  # Return the appropriate package
  if dmsPackage != null then dmsPackage else dmsSimple
