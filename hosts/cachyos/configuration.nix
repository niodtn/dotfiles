{
  inputs,
  self,
  ...
}: let
  hostName = builtins.baseNameOf ./.;
in {
  flake.systemConfigs.${hostName} = inputs.system-manager.lib.makeSystemConfig {
    modules = [
      self.commonModules.hostOptions

      # Host Specific
      {
        host.system = "x86_64-linux";
        system-manager.allowAnyDistro = true;
      }
    ];
  };
}
