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

      {
        host = {inherit system;};
      }

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
