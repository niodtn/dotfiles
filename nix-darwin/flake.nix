{
  description = "Niodtn's darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util }: {
    darwinConfigurations."mac" = nix-darwin.lib.darwinSystem { # "" <- `$ scutil --get LocalHostName`
      modules =
        [
        mac-app-util.darwinModules.default
        ./configuration.nix
        ./pkgs.nix
        ];
    };
    darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem { # "" <- `$ scutil --get LocalHostName`
      modules =
        [
        mac-app-util.darwinModules.default
        ./configuration.nix
        ./macbook.nix
        ./pkgs.nix
        ];
    };
  };
}
