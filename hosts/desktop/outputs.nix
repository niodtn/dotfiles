inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
    ./configuration.nix
  ];

  # Inputs
  inputs = {
    disko = true;
    cachyos-kernel = true;
    nix-flatpak = true;

    home-manager = true;
    plasma-manager = true;
    zen-browser-flake = true;
  };
}
