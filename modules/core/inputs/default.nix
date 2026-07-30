{inputs, ...}: {
  imports = [inputs.flake-file.flakeModules.default];

  flake-file = {
    inputs = {
      flake-aspects.url = "github:vic/flake-aspects";
      flake-file.url = "github:vic/flake-file";
      flake-parts.url = "github:hercules-ci/flake-parts";
      import-tree.url = "github:denful/import-tree";
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixConfig = {
      extra-substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
