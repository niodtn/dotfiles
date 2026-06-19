inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
    ./configuration.nix
  ];

  # Inputs
  inputs = {
    disko = true;
  };
}
