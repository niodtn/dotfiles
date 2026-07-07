{
  lib,
  config,
  ...
}: {
  options = {
    inputs.nix-darwin = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.nix-darwin {
    flake-file = {
      inputs.nix-darwin = {
        url = "github:nix-darwin/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixConfig = {
        extra-substituters = ["https://nix-darwin.cachix.org"];
        extra-trusted-public-keys = ["nix-darwin.cachix.org-1:LxMyKzQk7Uqkc1Pfq5uhm9GSn07xkERpy+7cpwc006A="];
      };
    };
  };
}
