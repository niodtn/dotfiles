{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    inputs.home-manager = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.home-manager {
    flake-file.inputs.home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake.aspects.core = let
      common = {config, ...}: {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";

          users.${config.host.userName} = {
            programs.man.enable = false;
          };
        };
      };
    in {
      nixos = lib.mkMerge [
        common
        {
          imports = [inputs.home-manager.nixosModules.home-manager];
        }
      ];
      darwin = lib.mkMerge [
        common
        ({config, ...}: {
          imports = [inputs.home-manager.darwinModules.home-manager];
          users.users.${config.host.userName}.home = "/Users/${config.host.userName}";
        })
      ];
    };
  };
}
