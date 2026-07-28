{
  lib,
  config,
  ...
}: {
  options = {
    programs._1password = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.programs._1password {
    flake.aspects.programs = let
      common = {
        programs = {
          _1password.enable = true;
          _1password-gui.enable = true;
        };
      };

      nixos = lib.mkMerge [
        common
        ({config, ...}: {
          programs._1password-gui.polkitPolicyOwners = [config.host.userName];
        })
      ];
    in {
      nixos = nixos;
      darwin = common;
    };
  };
}
