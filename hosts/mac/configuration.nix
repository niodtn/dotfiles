{inputs, ...}: let
  system = "aarch64-darwin";
  hostName = baseNameOf ./.;
in {
  flake.darwinConfigurations.${hostName} = inputs.nix-darwin.lib.darwinSystem {
    inherit system;

    modules = with inputs.self.modules.darwin; [
      core
      ./darwin
      ./home

      onePassword
      syncthing
      cryptomator

      zed-editor
      obsidian

      {
        system.stateVersion = 7;

        host = {
          inherit system hostName;
        };
      }
    ];
  };
}
