{
  inputs,
  self,
  ...
}: let
  system = "x86_64-linux";
  hostName = builtins.baseNameOf ./.;
in {
  flake = {
    nixosModules.commonConfig = {pkgs, ...}: {
      imports = [
        inputs.disko.nixosModules.disko
        inputs.self.modules.nixos.core
        ./hardware/disko.nix
      ];

      config = {
        system.stateVersion = "26.11";
        documentation.nixos.enable = false;

        environment.systemPackages = with pkgs; [
          git
        ];

        host = {
          inherit system hostName;
        };
      };
    };

    # === Minimal set for first-time installation ===
    nixosConfigurations.minimal = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        self.nixosModules.commonConfig

        {
          boot.loader.systemd-boot.enable = true;
          users.users.root = {
            password = null;
            extraGroups = ["wheel"];
          };
          services.getty.autologinUser = "root";
        }
      ];
    };

    # === Full configuration ===
    nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        self.nixosModules.commonConfig
        ./hardware

        ({config, ...}: {
          boot = {
            loader.systemd-boot.enable = true;
            initrd.systemd.enable = true;
          };

          users.users.${config.host.userName} = {
            hashedPassword = "$y$j9T$FiIoFpdVFv30Viq0WYsDS1$5VGzz7Itx1PEVGmnwOJJIN12YAfFQ3JoaaE6dBiyYd9";
          };
        })

        # CachyOS Kernel
        ({pkgs, ...}: {
          nixpkgs.overlays = [inputs.cachyos-kernel.overlays.pinned];
          boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
        })
      ];
    };
  };
}
