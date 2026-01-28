{
  description = "Niodtn's flake";

  inputs = {
    # All
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Darwin
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # VSCode Extensions
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS Gaming
    nix-gaming.url = "github:fufexan/nix-gaming";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
  };

  # https://github.com/numtide/blueprint
  outputs = inputs:
    inputs.blueprint {
      inherit inputs;
      prefix = "nix/";
    };
}
