{
  lib,
  config,
  ...
}: {
  options = {
    inputs.hjem = lib.mkOption {
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.inputs.hjem {
    flake-file.inputs.hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
