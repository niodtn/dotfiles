{
  inputs,
  self,
  ...
}: let
  system = "aarch64-linux";
in {
  flake.nixosConfigurations.${baseNameOf ./.} = inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    modules = with self.modules.nixos; [
      core
      {host = {inherit system;};}

      programs
      services

      asahi
    ];
  };
}
