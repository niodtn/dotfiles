{
  description = "Niodtn's darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util }:

    let
      conf = { pkgs, ... }: {
        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };

    in
    {
      darwinConfigurations."20nabiui-MacBookAir" = nix-darwin.lib.darwinSystem {
        # "" <- `$ scutil --get LocalHostName`
        modules = [
          conf
          mac-app-util.darwinModules.default
          ./configuration.nix
          ./packages.nix
        ];
      };
    };
}
