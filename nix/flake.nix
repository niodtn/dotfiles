{
  description = "Niodtn's flake";

  inputs = {
    # All
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    # Darwin
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  # https://github.com/numtide/blueprint
  outputs = inputs: inputs.blueprint { inherit inputs; };
}
