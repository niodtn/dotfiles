{
  inputs,
  self,
  ...
}: let
  system = "x86_64-linux";
  hostName = builtins.baseNameOf ./.;
in {
  flake = {
    nixosModules.commonConfig = {
      imports = [
        inputs.disko.nixosModules.disko
        self.commonModules.hostOptions
        ./hardware/disko.nix
      ];

      config = {
        host.system = system;
        system.stateVersion = "26.11";
      };
    };

    # === Minimal set for first-time installation ===
    nixosConfigurations.minimal = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        self.nixosModules.commonConfig

        {
          boot.loader.systemd-boot.enable = true;
        }
      ];
    };

    # === Full configuration ===
    nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        self.nixosModules.commonConfig
      ];
    };
  };
}
