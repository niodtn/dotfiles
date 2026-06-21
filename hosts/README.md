# Templates

## flake.nix

```nix
# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: import ./outputs.nix inputs;

  inputs = {
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}

```

## outputs.nix

```nix
inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
  ];
}

```
