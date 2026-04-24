{
  self,
  inputs,
  ...
}: {
  flake.darwinConfigurations.mac = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      self.darwinModules.macConfiguration
    ];
  };
}
