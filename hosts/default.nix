{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.flake-file.flakeModules.default
    ../inputs
  ];

  systems = inputs.nixpkgs.lib.systems.flakeExposed;

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

  flake.commonModules.hostOptions = {config, ...}: {
    options.host = {
      system = lib.mkOption {
        type = lib.types.enum inputs.nixpkgs.lib.systems.flakeExposed;
      };
    };

    config = {
      nixpkgs.hostPlatform = lib.mkDefault config.host;
    };
  };
}
