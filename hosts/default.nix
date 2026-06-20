{
  inputs,
  self,
  config,
  ...
}: let
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];
in {
  imports = [
    inputs.flake-file.flakeModules.default
    ../inputs
  ];

  inherit systems;

  flake-file = {
    inputs = {
      flake-file.url = "github:vic/flake-file";
      flake-parts.url = "github:hercules-ci/flake-parts";
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixConfig = {
      extra-substituters = ["https://nix-community.cachix.org"];
      extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    };
  };

  flake.commonModules = {
    core = {
      imports = [self.commonModules.hostOptions];

      config = {
        nix.settings = {
          experimental-features = ["nix-command" "flakes"];
          extra-substituters = config.flake-file.nixConfig.extra-substituters;
          extra-trusted-public-keys = config.flake-file.nixConfig.extra-trusted-public-keys;
        };

        nixpkgs.config.allowUnfree = true;
      };
    };

    hostOptions = {
      lib,
      config,
      ...
    }: {
      options.host = {
        system = lib.mkOption {
          type = lib.types.enum systems;
        };
        name = lib.mkOption {
          type = lib.types.str;
        };
      };

      config = {
        nixpkgs.hostPlatform = config.host.system;
        networking.hostName = config.host.name;
      };
    };
  };
}
