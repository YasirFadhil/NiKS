{ pkgs, lib, config, ... }:

{
  systemd.user.services.xwayland-niri = {
    Unit = {
      Description = "XWayland server for Niri";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.xwayland}/bin/Xwayland :0 -rootless -listen tcp";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.sessionVariables = {
    DISPLAY = ":0";
  };
}
