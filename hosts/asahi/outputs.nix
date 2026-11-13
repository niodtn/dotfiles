inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
  ];

  inputs.apple-silicon-support = true;
  flake.aspects.core.nixos = {config, ...}: {
    host.hostName = baseNameOf ./.;

    # statVersions
    system.stateVersion = "26.11";
  };
}

