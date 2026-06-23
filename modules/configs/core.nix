{config, ...}: let
  common = {
    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
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
  flake.aspects = {aspects, ...}: {
    core = {
      includes = with aspects; [host];
      nixos = common;
      darwin = common;
    };
  };
}
