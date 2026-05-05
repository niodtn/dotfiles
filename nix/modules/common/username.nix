{lib, ...}: {
  # For System Scope
  options.username = lib.mkOption {
    type = lib.types.str;
    default = "niodtn";
  };
}
