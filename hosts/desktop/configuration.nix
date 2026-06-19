{
  inputs,
  self,
  ...
}: let
  system = "x86_64-linux";
  hostName = builtins.baseNameOf ./.;
in {
  flake = {
    # Minimal set for first-time installation
    nixosModules.minimal = {
      imports = [
        self.commonModules.hostOptions
      ];

      config = {
        host.system = system;
        system.stateVersion = "26.11";
      };
    };

    nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        self.nixosModules.minimal
      ];
    };
  };
}
