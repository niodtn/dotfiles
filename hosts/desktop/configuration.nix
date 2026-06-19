{
  inputs,
  self,
  ...
}: let
  hostName = builtins.baseNameOf ./.;
in {
  flake.nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.commonModules.hostOptions

      # Host Specific
      {
        host.system = "x86_64-linux";
      }
    ];
  };
}
