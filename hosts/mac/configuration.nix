{
  inputs,
  self,
  ...
}: let
  system = "aarch64-darwin";
  hostName = builtins.baseNameOf ./.;
in {
  flake.darwinConfigurations.${hostName} = inputs.nix-darwin.lib.darwinSystem {
    inherit system;

    modules = [
      inputs.self.modules.darwin.core

      # Host Specific
      {
        system.stateVersion = 7;

        host = {
          inherit system hostName;
        };
      }
    ];
  };
}
