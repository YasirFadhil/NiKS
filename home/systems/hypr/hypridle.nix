{ pkgs, ... }:

{
  home.file.".config/hypr/hypridle.conf".text = ''
    $iDIR="/etc/nixos/home/themes/wallpaper/wallpaper.jpg"

    general {
        # use noctalia-shell ipc call for lock screen
        # lock_cmd = noctalia-shell ipc call lockScreen lock
        lock_cmd = hyprlock
        before_sleep_cmd = loginctl lock-session
        # Use hyprctl if available (Hyprland), otherwise niri msg for Niri
        after_sleep_cmd = command -v hyprctl >/dev/null && hyprctl dispatch dpms on || niri msg action power-on-monitors
        ignore_dbus_inhibit = false
    }



    listener {
        timeout = 300
        on-timeout = loginctl lock-session
    }

    listener {
        timeout = 660
        # Turn off displays after longer idle period - try hyprctl first, fallback to niri
        on-timeout = command -v hyprctl >/dev/null && hyprctl dispatch dpms off || niri msg action power-off-monitors
        on-resume = command -v hyprctl >/dev/null && hyprctl dispatch dpms on || niri msg action power-on-monitors
    }

    listener {
        timeout = 3600
        on-timeout = systemctl suspend
    }
  '';
}
