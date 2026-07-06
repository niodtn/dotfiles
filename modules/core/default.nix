{
  config,
  lib,
  ...
}: let
  common = {
    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 14d --max-freed 10G";
      };
      settings = {
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
        extra-substituters = config.flake-file.nixConfig.extra-substituters;
        extra-trusted-public-keys = config.flake-file.nixConfig.extra-trusted-public-keys;
      };
    };
    nixpkgs.config.allowUnfree = true;
  };
in {
  flake.aspects.core = {
    nixos = lib.mkMerge [
      common
      {nix.gc.dates = "weekly";}
    ];
    darwin = common;
  };
}
