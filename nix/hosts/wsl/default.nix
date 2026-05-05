{
  inputs,
  self,
  ...
}: let
  system = "x86_64-linux";
  stateVersion = "26.05";
in {
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs self;};

    modules = [
      (self.paths.profiles "nixos")

      ({config, ...}: {
        # Nix
        system.stateVersion = stateVersion;

        # Home Manager
        home-manager.users.${config.username}.home.stateVersion = stateVersion;
      })
    ];
  };
}
