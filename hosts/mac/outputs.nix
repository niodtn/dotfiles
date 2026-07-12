inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
    ./configuration.nix
  ];

  inputs = {
    nix-darwin = true;
    opnix = true;

    home-manager = true;
  };
}
