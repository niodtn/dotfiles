{
  lib,
  config,
  ...
}: {
  options = {
    services.openssh = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.services.openssh {
    services.tailscale = true;

    flake.aspects.services = let
      common = {
        services.openssh = {
          enable = true;
        };
      };
      nixos = lib.mkMerge [
        common
        {environment.enableAllTerminfo = true;}
      ];
    in {
      nixos = nixos;
      darwin = common;
    };
  };
}
