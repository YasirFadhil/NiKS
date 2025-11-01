{ pkgs, ... }:

{
  home.file.".config/hypr/hypridle.conf".text = ''
    $iDIR="$HOME/.config/swaync/images/ja.png"

    general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
        ignore_dbus_inhibit = false
    }

    listener {
        timeout = 30
        on-timeout = pidof hyprlock && hyprctl dispatch dpms off
        on-resume = pidof hyprlock && hyprctl dispatch dpms on
    }

    listener {
        timeout = 300
        on-timeout = loginctl lock-session
    }

    listener {
        timeout = 660
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on
    }

    listener {
        timeout = 3600
        on-timeout = systemctl suspend
    }
  '';
}
