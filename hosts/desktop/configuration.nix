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
        {host = {inherit system;};}

        ({
          pkgs,
          config,
          ...
        }: {
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
        {host = {inherit system;};}

        programs
        services
        wayland
        desktop

        # --- old ---

        onePassword

        zen-browser
        zed-editor
        obsidian

        {
          boot = {
            loader.systemd-boot.enable = true;
            initrd.systemd.enable = true;
          };
        }
      ];
    };
  };
}
