{ lib, ... }:

{
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Contoh opsi baru";
    };
  };
}
