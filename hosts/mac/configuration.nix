{inputs, ...}: let
  system = "aarch64-darwin";
  hostName = builtins.baseNameOf ./.;
in {
  flake.darwinConfigurations.${hostName} = inputs.nix-darwin.lib.darwinSystem {
    inherit system;

    modules = with inputs.self.modules.darwin; [
      core
      vcs
      ./darwin
      ./home

      {
        system.stateVersion = 7;

        host = {
          inherit system hostName;
        };
      }
    ];
  };
}
