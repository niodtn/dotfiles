inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
    ./configuration.nix
  ];

  inputs = {
    nixos-wsl = true;
    home-manager = true;
  };

  services = {
    openssh = true;
    tailscale = true;
  };

  flake.aspects.core.nixos = {config, ...}: {
    host.hostName = baseNameOf ./.;

    system.stateVersion = "26.11";
    home-manager.users.${config.host.userName}.home.stateVersion = "26.11";
  };
}
