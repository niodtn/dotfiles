{
  inputs,
  self,
  ...
}: let
  system = "aarch64-linux";
  stateVersion = "26.05";
in {
  flake.nixosConfigurations.asahi = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs self;};

    modules = [
      inputs.apple-silicon-support.nixosModules.apple-silicon-support
      (self.paths.profiles "nixos")

      ({config, ...}: {
        # Nix
        system.stateVersion = stateVersion;

        hardware.asahi.peripheralFirmwareDirectory = /boot/asahi;

        # Home Manager
        home-manager.users.${config.username}.home.stateVersion = stateVersion;
      })
    ];
  };
}
