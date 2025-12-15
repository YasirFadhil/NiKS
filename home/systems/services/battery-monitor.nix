{ pkgs, ... }:

{
  systemd.user.services.battery-monitor = {
    Unit = {
      Description = "Battery State Monitor with Sound Notifications";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.bash}/bin/bash -c 'export DBUS_SESSION_BUS_ADDRESS=\"unix:path=/run/user/$(id -u)/bus\"; export XDG_RUNTIME_DIR=\"/run/user/$(id -u)\"; ${pkgs.upower}/bin/upower -m'";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.battery-notify = {
    Unit = {
      Description = "Battery State Notification Service";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.python3}/bin/python3 ${pkgs.writeText "battery-notify.py" ''
import subprocess
import time
import os
from pathlib import Path

os.environ['DBUS_SESSION_BUS_ADDRESS'] = f"unix:path=/run/user/{os.getuid()}/bus"
os.environ['XDG_RUNTIME_DIR'] = f"/run/user/{os.getuid()}"

CHARGING_SOUND = "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/power-plug.oga"
DISCHARGING_SOUND = "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/power-unplug.oga"
NOTIFY_ID = "8888"

def get_battery_info():
    try:
        result = subprocess.run(
            ["${pkgs.upower}/bin/upower", "-e"],
            capture_output=True,
            text=True,
            timeout=5
        )
        state = None
        percentage = None
        for line in result.stdout.split('\n'):
            if 'state' in line.lower():
                state = line.split()[-1].strip()
            if 'percentage' in line.lower():
                percentage = line.split()[-1].strip()
        return state, percentage
    except Exception as e:
        print(f"Error getting battery info: {e}")
        return None, None

def play_sound(sound_file):
    if Path(sound_file).exists():
        try:
            subprocess.Popen(["${pkgs.pipewire}/bin/paplay", sound_file])
        except Exception as e:
            print(f"Error playing sound: {e}")

def send_notification(title, message):
    try:
        subprocess.run([
            "${pkgs.libnotify}/bin/notify-send",
            "--replace-id=" + NOTIFY_ID,
            "-u", "normal",
            "-t", "2000",
            "--hint=int:transient:1",
            title,
            message
        ], timeout=5)
    except Exception as e:
        print(f"Error sending notification: {e}")

def main():
    prev_state = None

    while True:
        try:
            state, percentage = get_battery_info()

            if state and state != prev_state:
                if state in ["charging", "fully-charged"]:
                    play_sound(CHARGING_SOUND)
                    send_notification("⚡ Charging", percentage or "")
                elif state == "discharging":
                    play_sound(DISCHARGING_SOUND)
                    send_notification("🔋 Discharging", percentage or "")

                prev_state = state

            time.sleep(2)
        except KeyboardInterrupt:
            break
        except Exception as e:
            print(f"Error in main loop: {e}")
            time.sleep(5)

if __name__ == "__main__":
    main()
''}";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
