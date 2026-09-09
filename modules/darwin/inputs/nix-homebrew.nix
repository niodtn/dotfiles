{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    inputs.nix-homebrew = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.nix-homebrew {
    flake-file.inputs = {
      nix-homebrew.url = "github:zhaofengli/nix-homebrew";

      homebrew-core = {
        url = "github:homebrew/homebrew-core";
        flake = false;
      };
      homebrew-cask = {
        url = "github:homebrew/homebrew-cask";
        flake = false;
      };
    };

    flake.aspects.core.darwin = {config, ...}: {
      imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        onActivation.upgrade = true;
        brews = ["mas"];
        taps = builtins.attrNames config.nix-homebrew.taps;
      };

      nix-homebrew = {
        enable = true;
        user = config.host.userName;
        enableRosetta = true;
        autoMigrate = true;

        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
        };
      };
    };
  };
}
