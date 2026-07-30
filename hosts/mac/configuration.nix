{
  inputs,
  self,
  ...
}: let
  system = "aarch64-darwin";
  hostName = baseNameOf ./.;

  configurations = {
    system = {
      host = {inherit system hostName;};
      system.stateVersion = 7;
    };

    home = {
      home.stateVersion = "26.11";
    };
  };
in {
  flake.darwinConfigurations.${hostName} = inputs.nix-darwin.lib.darwinSystem {
    inherit system;

    modules = with self.modules.darwin; [
      core
      services
      ./darwin

      fish
      starship
      direnv

      onePassword
      cryptomator

      zen-browser
      zed-editor
      obsidian

      ({config, ...}: {
        imports = [configurations.system];
        home-manager.users.${config.host.userName}.imports = [configurations.home];
      })

      ({config, ...}: {
        home-manager.users.${config.host.userName} = {pkgs, ...}: {
          home.packages = with pkgs; [
            spotify
            discord
          ];
        };
      })
    ];
  };
}
