{ pkgs, config, ... }:

{
  # Only enable hypridle for Niri, not for Hyprland
  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;

    settings = {
      general = {
        lock_cmd = "swaylock-blur";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "brightnessctl s 100";
        ignore_dbus_inhibit = false;
      };

      listener = [
        # Turn off display after 5 minutes of inactivity (only if locked)
        {
          timeout = 300;
          on-timeout = "if pgrep -x swaylock > /dev/null; then brightnessctl s 0; fi";
          on-resume = "brightnessctl s 100";
        }

        # Lock screen after 10 minutes of inactivity
        {
          timeout = 600;
          on-timeout = "swaylock-blur";
        }

        # Suspend after 30 minutes of inactivity
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  # Ensure hypridle and required tools are available
  home.packages = with pkgs; [
    hypridle
    brightnessctl
    swaylock-effects
  ];
}
