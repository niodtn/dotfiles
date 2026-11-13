{
  lib,
  config,
  ...
}: {
  options = {
    services.syncthing = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.services.syncthing {
    services.tailscale = true;

    flake.aspects.services = let
      common = {imports = [./_common];};
    in {
      nixos = common;
      darwin = common;
    };
  };
}
