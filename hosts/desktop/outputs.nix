inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
    ./modules
    ./configuration.nix
  ];

  inputs = {
    disko = true;
    cachyos-kernel = true;

    home-manager = true;
    zen-browser-flake = true;
  };

  services = {
    openssh = true;
    syncthing = true;
  };

  wm.plasma = true;
  etc.autoLogin = true;
}
