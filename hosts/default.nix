{
  inputs,
  self,
  config,
  ...
}: let
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];
in {
  imports = [
    ../inputs
  ];

  inherit systems;

  flake.commonModules = {
    core = {
      imports = [self.commonModules.hostOptions];

      config = {
        nix.settings = {
          experimental-features = ["nix-command" "flakes"];
          extra-substituters = config.flake-file.nixConfig.extra-substituters;
          extra-trusted-public-keys = config.flake-file.nixConfig.extra-trusted-public-keys;
        };

        nixpkgs.config.allowUnfree = true;
      };
    };

    hostOptions = {
      lib,
      config,
      ...
    }: {
      options.host = {
        system = lib.mkOption {
          type = lib.types.enum systems;
        };
        name = lib.mkOption {
          type = lib.types.str;
        };
      };

      config = {
        nixpkgs.hostPlatform = config.host.system;
        networking.hostName = config.host.name;
      };
    };
  };
}
