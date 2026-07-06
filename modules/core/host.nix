{lib, ...}: let
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];
  common = {config, ...}: {
    options.host = {
      system = lib.mkOption {
        type = lib.types.enum systems;
      };
      hostName = lib.mkOption {
        type = lib.types.str;
      };
      userName = lib.mkOption {
        type = lib.types.str;
        default = "niodtn";
      };
    };

    config = {
      nixpkgs.hostPlatform = config.host.system;
      networking.hostName = config.host.hostName;
    };
  };
in {
  inherit systems;

  flake.aspects.core = {
    nixos = lib.mkMerge [
      common
      ({config, ...}: {
        users.users.${config.host.userName} = {
          isNormalUser = true;
          extraGroups = ["wheel"];
        };
      })
    ];
    darwin = lib.mkMerge [
      common
      ({config, ...}: {
        networking.computerName = config.host.hostName;
        networking.localHostName = config.host.hostName;

        system.primaryUser = config.host.userName;
      })
    ];
  };
}
