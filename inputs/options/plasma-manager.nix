{
  lib,
  inputs,
  ...
}: {
  options = {
    inputs.plasma-manager = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    flake-file.inputs.plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    flake.aspects.core.nixos = {
      home-manager.sharedModules = [inputs.plasma-manager.homeModules.plasma-manager];
    };
  };
}
