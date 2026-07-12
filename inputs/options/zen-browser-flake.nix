{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    inputs.zen-browser-flake = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.zen-browser-flake {
    flake-file.inputs.zen-browser-flake = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    flake.aspects.core = let
      common = {
        home-manager.sharedModules = [inputs.zen-browser-flake.homeModules.default];
      };
    in {
      nixos = common;
      darwin = common;
    };
  };
}
