{
  inputs,
  self,
  ...
}: let
  system = "aarch64-darwin";
  stateVersion = "26.05";
in {
  flake.darwinConfigurations.mac = inputs.nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {inherit inputs self;};

    modules = [
      (self.paths.profiles "darwin")

      ({config, ...}: {
        # Nix
        system.stateVersion = 6; # $ darwin-rebuild changelog

        # Home Manager
        home-manager.users.${config.username}.home.stateVersion = stateVersion;
      })
    ];
  };
}
