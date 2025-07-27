{
  description = "Niodtn's darwin system";

  inputs = {
    # All
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";

    # Darwin
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit self inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      # Darwin
      flake.darwinConfigurations.mac = inputs.nix-darwin.lib.darwinSystem {
        system = builtins.currentSystem;
        specialArgs = { inherit inputs self; };

        modules = [
          inputs.mac-app-util.darwinModules.default
          inputs.nix-homebrew.darwinModules.nix-homebrew
          inputs.home-manager.darwinModules.home-manager

          ./mac/configuration.nix
          ./mac/home-manager.nix
          {
            # https://github.com/LnL7/nix-darwin/blob/master/modules/examples/flake/flake.nix
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = 6;
            nix.settings.experimental-features = "nix-command flakes";
          }
        ];
      };
    };
}
