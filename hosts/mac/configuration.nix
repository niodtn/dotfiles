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

      direnv

      onePassword
      syncthing
      cryptomator

      zen-browser
      zed-editor
      obsidian

      ({pkgs, ...}: {
        system.stateVersion = 7;

        host = {
          inherit system hostName;
        };

        environment.systemPackages = with pkgs; [
          spotify
        ];
      })
    ];
  };
}
