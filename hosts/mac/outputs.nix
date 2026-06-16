inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
    ./configuration.nix
  ];

  flake-file = {
    inputs = {
      nix-darwin.url = "github:nix-darwin/nix-darwin";
      nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
      nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    };

    nixConfig = {
      extra-substituters = ["https://nix-darwin.cachix.org"];
      extra-trusted-public-keys = ["nix-darwin.cachix.org-1:LxMyKzQk7Uqkc1Pfq5uhm9GSn07xkERpy+7cpwc006A="];
    };
  };
}
