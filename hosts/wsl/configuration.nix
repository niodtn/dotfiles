{
  inputs,
  self,
  ...
}: let
  system = "x86_64-linux";
in {
  flake.nixosConfigurations.${baseNameOf ./.} = inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    modules = with self.modules.nixos; [
      core
      services

      ({config, ...}:{
        host = {inherit system;};

        home-manager.users.${config.host.userName} = {
          imports = [self.modules.homeManager.programs];
        };
      })
    ];
  };
}
