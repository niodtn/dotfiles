{
  description = "Niodtn's darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      mac-app-util,
      nix-homebrew,
      ...
    }:
    let
      global-configuration = [
        {
          # https://github.com/LnL7/nix-darwin/blob/master/modules/examples/flake/flake.nix
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 5;
          nix.settings.experimental-features = "nix-command flakes";
        }
      ];
      mac-configuration = global-configuration ++ [
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
      ];
    in
    {
      darwinConfigurations = {
        niodtn = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = mac-configuration ++ [ ./mac/mac.nix ];
        };
      };
    };
}
