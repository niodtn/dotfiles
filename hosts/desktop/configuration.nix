{inputs, ...}: let
  hostName = builtins.baseNameOf ./.;
in {
  flake.systemConfigs.${hostName} = inputs.system-manager.lib.makeSystemConfig {
    modules = [
      self.commonModules.hostOptions
    ];
  };
}
