{
  inputs,
  self,
  pkgs,
  ...
}: let
  system = "x86_64-linux";
  stateVersion = "26.05";
in {
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs self;};

    modules = [
      inputs.nixos-wsl.nixosModules.default
      (self.paths.profiles "nixos")

      ({config, ...}: {
        # Nix
        system.stateVersion = stateVersion;

        username = "nixos";
        wsl.defaultUser = config.username;

        wsl.enable = true;
        wsl.wslConf.boot.systemd = true;
        environment.systemPackages = [pkgs.wslu];

        # Home Manager
        home-manager.users.${config.username} = {
          programs.bash = {
            enable = true;
            enableCompletion = true;

            # For atuin with Visual Studio Code - Remote SSH
            initExtra = ''
              export XDG_RUNTIME_DIR="/run/user/$(id -u)"
            '';
          };

          home = {
            stateVersion = stateVersion;
            shell.enableBashIntegration = true;
            shellAliases = {
              rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#wsl";
            };
          };
        };
      })
    ];
  };
}
