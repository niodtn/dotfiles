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

      {
        host = {inherit system;};
      }
    ];
  };
}
