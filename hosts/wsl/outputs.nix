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

    # stateVersions
    system.stateVersion = "26.11";
    home-manager.users.${config.host.userName}.home.stateVersion = "26.11";

    # Passwords
    users.users = {
      root.hashedPassword = "!";
      ${config.host.userName}.hashedPassword = "$y$j9T$FiIoFpdVFv30Viq0WYsDS1$5VGzz7Itx1PEVGmnwOJJIN12YAfFQ3JoaaE6dBiyYd9";
    };
  };
}
