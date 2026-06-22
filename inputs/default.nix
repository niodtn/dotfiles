{inputs, ...}: {
  imports = [
    inputs.flake-file.flakeModules.default
    (inputs.import-tree ./options)
  ];

  flake-file = {
    inputs = {
      flake-aspects.url = "github:vic/flake-aspects";
      flake-file.url = "github:vic/flake-file";
      flake-parts.url = "github:hercules-ci/flake-parts";
      import-tree.url = "github:denful/import-tree";
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixConfig = {
      extra-substituters = ["https://nix-community.cachix.org"];
      extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    };
  };
}
