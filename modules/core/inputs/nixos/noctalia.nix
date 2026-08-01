{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    inputs.noctalia = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.noctalia {
    inputs.home-manager = true;

    flake-file = {
      inputs = {
        noctalia = {
          url = "github:noctalia-dev/noctalia";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        noctalia-greeter = {
          url = "github:noctalia-dev/noctalia-greeter";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      };

      nixConfig = {
        extra-substituters = ["https://noctalia.cachix.org"];
        extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
      };
    };

    flake.aspects.core.nixos = {
      imports = [inputs.noctalia-greeter.nixosModules.default];
      home-manager.sharedModules = [inputs.noctalia.homeModules.default];
    };
  };
}
