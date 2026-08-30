inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
    ./modules
    ./configuration.nix
  ];

  inputs = {
    cachyos-kernel = true;

    home-manager = true;
    zen-browser-flake = true;
  };

  hardware = {
    amd = true;
    nvidia = true;
    disko = true;
    airpods = true;
    it8613e = true;
  };

  services = {
    openssh = true;
    syncthing = true;
  };

  programs = {
    ghostty = true;
  };

  gaming = {
    steam = true;
    minecraft = true;
  };

  wm.niri = true;
  etc.noctalia = true;

  flake.aspects.core.nixos = {config, ...}: {
    host.hostName = baseNameOf ./.;

    # stateVersion
    system.stateVersion = "26.11";
    home-manager.users.${config.host.userName}.home.stateVersion = "26.11";

    # Password
    users.users = {
      root.hashedPassword = "!";
      ${config.host.userName}.hashedPassword = "$y$j9T$FiIoFpdVFv30Viq0WYsDS1$5VGzz7Itx1PEVGmnwOJJIN12YAfFQ3JoaaE6dBiyYd9";
    };

    # etc
    documentation.nixos.enable = false;
  };
}
