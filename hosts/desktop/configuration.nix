{
  self,
  inputs,
  ...
}: let
  system = "x86_64-linux";
in {
  flake.nixosConfigurations = {
    # === Minimal set for first-time installation ===
    minimal = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = with self.modules.nixos; [
        core

        ({
          pkgs,
          config,
          ...
        }: {
          host = {inherit system;};

          boot.loader.systemd-boot.enable = true;
          environment.systemPackages = with pkgs; [git];

          services.getty.autologinUser = config.host.userName;
        })
      ];
    };

    # === Full configuration ===
    ${baseNameOf ./.} = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = with self.modules.nixos; [
        core
        programs
        services
        desktop

        fish
        starship
        direnv

        onePassword

        zen-browser
        zed-editor
        obsidian

        ({pkgs, ...}: {
          host = {inherit system;};

          boot = {
            kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
            loader.systemd-boot.enable = true;
            initrd.systemd.enable = true;
          };
        })

        ({config, ...}: {
          home-manager.users.${config.host.userName} = {
            imports = [self.modules.homeManager.programs];
          };
        })
      ];
    };
  };
}
