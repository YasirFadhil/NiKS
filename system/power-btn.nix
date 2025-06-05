{ config, lib, ... }:

{
  options.yasirfadhil.powerKeyAction = lib.mkOption {
    type = lib.types.str;
    default = "ignore";
  };

  config = {
    services.logind.extraConfig = ''
      HandlePowerKey=${config.yasirfadhil.powerKeyAction}
    '';
  };
}
