{
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    inputs.opnix = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.opnix {
    flake-file.inputs.opnix.url = "github:brizzbuzz/opnix";

    flake.aspects.core = {
      nixos = {
        imports = [inputs.opnix.nixosModules.default];
      };
      darwin = {
        imports = [inputs.opnix.darwinModules.default];
      };
    };
  };
}
