{ config, lib, ... }:

let
  username = config.var.username;
in
{
  options.username.powerKeyAction = lib.mkOption {
    type = lib.types.str;
    default = "ignore";
  };

  config = {
    services.logind.settings.Login.HandlePowerKey = config.username.powerKeyAction;
  };
}
