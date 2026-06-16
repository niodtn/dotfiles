{
  inputs,
  self,
  ...
}: let
  hostName = builtins.baseNameOf ./.;
in {
  flake.darwinConfigurations.${hostName} = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      self.commonModules.hostOptions
      {
        host.system = "aarch64-darwin";
        system.stateVersion = 7;
      }
    ];
  };
}
