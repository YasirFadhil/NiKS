{ lib, ... } : {
option =
 var = lib.mkOption {
   type = lib.types.string;
   default = "example";
 };
}
