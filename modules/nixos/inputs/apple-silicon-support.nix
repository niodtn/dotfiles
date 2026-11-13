{
 lib,
 config,
 inputs,
 ... 
}: {
  options = {
    inputs.apple-silicon-support = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.apple-silicon-support {
    flake-file.inputs.apple-silicon-support = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake.aspects.core.nixos = {
      imports = [inputs.apple-silicon-support.nixosModules.apple-silicon-support];
    };
  };
}
