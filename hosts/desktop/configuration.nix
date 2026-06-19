{
  inputs,
  self,
  ...
}: let
  system = "x86_64-linux";
  hostName = builtins.baseNameOf ./.;
in {
  flake.nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      self.commonModules.hostOptions

      # Host Specific
      {
        host.system = system;
        system.stateVersion = "26.11";
      }
    ];
  };
}
