{
  inputs,
  self,
  ...
}: let
  system = "aarch64-darwin";
in {
  flake.darwinConfigurations.${baseNameOf ./.} = inputs.nix-darwin.lib.darwinSystem {
    inherit system;

    modules = with self.modules.darwin; [
      core
      programs
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
        host = {inherit system;};

        home-manager.users.${config.host.userName} = {
          imports = [self.modules.homeManager.programs];
        };
      })

      ({config, ...}: {
        home-manager.users.${config.host.userName} = {pkgs, ...}: {
          home.packages = with pkgs; [
            spotify
            discord
            prismlauncher
          ];
        };
      })
    ];
  };
}
