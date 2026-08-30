inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
    ./configuration.nix
  ];

  inputs = {
    nix-darwin = true;

    home-manager = true;
    zen-browser-flake = true;
  };

  services = {
    tailscale = true;
    syncthing = true;
  };

  flake.aspects.core.darwin = {config, ...}: {
    host.hostName = baseNameOf ./.;

    # stateVersion
    system.stateVersion = 7;
    home-manager.users.${config.host.userName}.home.stateVersion = "26.11";
  };
}
