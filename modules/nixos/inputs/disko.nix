{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    inputs.disko = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.disko {
    flake-file.inputs.disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake.aspects.core.nixos = {
      imports = [inputs.disko.nixosModules.disko];
    };
  };
}
