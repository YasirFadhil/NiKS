{ config, lib, ... }:

{
  options.yasir.powerKeyAction = lib.mkOption {
    type = lib.types.str;
    default = "ignore";
  };

  config = {
    services.logind.extraConfig = ''
      HandlePowerKey=${config.yasir.powerKeyAction}
    '';
  };
}
