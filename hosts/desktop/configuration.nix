{inputs, ...}: let
  system = "x86_64-linux";
  hostName = baseNameOf ./.;

  common = {
    imports = with inputs.self.modules.nixos; [core ./nixos/hardware/disko.nix];
    system.stateVersion = "26.11";
    host = {inherit system hostName;};
    documentation.nixos.enable = false;
  };
in {
  flake = {
    # === Minimal set for first-time installation ===
    nixosConfigurations.minimal = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        common

        ({pkgs, ...}: {
          boot.loader.systemd-boot.enable = true;
          environment.systemPackages = with pkgs; [git];
          users.users.root = {
            password = null;
            extraGroups = ["wheel"];
          };
          services.getty.autologinUser = "root";
        })
      ];
    };

    # === Full configuration ===
    nixosConfigurations.${hostName} = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = with inputs.self.modules.nixos; [
        common
        ./nixos
        ./home

        onePassword
        syncthing

        zed-editor
        obsidian

        ({
          pkgs,
          config,
          ...
        }: {
          boot = {
            kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
            loader.systemd-boot.enable = true;
            initrd.systemd.enable = true;
          };

          users.users.${config.host.userName} = {
            hashedPassword = "$y$j9T$FiIoFpdVFv30Viq0WYsDS1$5VGzz7Itx1PEVGmnwOJJIN12YAfFQ3JoaaE6dBiyYd9";
          };
        })
      ];
    };
  };
}
