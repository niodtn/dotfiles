{
  inputs,
  lib,
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

  flake.commonModules.hostOptions = {config, ...}: {
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
}
