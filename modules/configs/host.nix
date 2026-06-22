{lib, ...}: let
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];
  common = {config, ...}: {
    options.host = {
      system = lib.mkOption {
        type = lib.types.enum systems;
      };
      hostName = lib.mkOption {
        type = lib.types.str;
      };
    };

    config = {
      nixpkgs.hostPlatform = config.host.system;
      networking.hostName = config.host.hostName;
    };
  };
in {
  inherit systems;

  flake.aspects = {
    host = {
      nixos = common;
      darwin = common;
    };
  };
}
