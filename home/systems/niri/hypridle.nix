{ pkgs, ... }:

{
  home.file.".config/niri/hypridle.conf".text = ''
    general {
        lock_cmd = pidof swaylock || swaylock-blur
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = niri msg action power-off-monitors
        ignore_dbus_inhibit = false
    }

    listener {
        timeout = 30
        on-timeout = pidof swaylock && niri msg action power-off-monitors
        on-resume = niri msg action power-off-monitors
    }

    listener {
        timeout = 300
        on-timeout = loginctl lock-session
    }

    listener {
        timeout = 660
        on-timeout = niri msg action power-off-monitors
        on-resume = niri msg action power-off-monitors
    }

    listener {
        timeout = 3600
        on-timeout = systemctl suspend
    }
  '';
}
