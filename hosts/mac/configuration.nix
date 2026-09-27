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
      {host = {inherit system;};}

      programs
      services

      # --- old ---
      ./darwin

      onePassword
      cryptomator

      zen-browser
      zed-editor
      obsidian

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
