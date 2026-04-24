{lib, ...}: {
  options = {
    # For NixOS & Darwin
    flake.commonModules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.unspecified;
      default = {};
    };

    # For Darwin
    flake.darwinModules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.unspecified;
      default = {};
      description = "nix-darwin modules";
    };
  };

  config = {
    systems = [
      "x86_64-linux"
      "aarch64-darwin"
      "aarch64-linux"
    ];
  };
}
