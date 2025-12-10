{config, ...}: {
  imports = [../nixos/system/var-conf.nix];

  config.var = {
    # hostname = "nixos";
    username = "yasirfadhil";
    # configDirectory =
    #   "/etc/"
    #   + config.var.username
    #   "/etc/nixos"; # The path of the nixos configuration directory

    # keyboardLayout = "us";
    # weather = "d62572757403946f6fa5d9702a932d2e";
    # location = "Klaten";
    # timeZone = "Asia/Jakarta";
    # defaultLocale = "en_US.UTF-8";
    # extraLocale = "en_US.UTF-8";

    git = {
      username = "YasirFadhil";
      email = "yasirfadhil46@gmail.com";
    };


    # Choose your theme variables here
    # theme = import ./themes/var/nixy.nix;
  };
}
