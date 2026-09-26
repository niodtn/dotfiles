{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    inputs.nixos-wsl = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.nixos-wsl {
    flake-file.inputs = {
      nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    };

    flake.aspects.core.nixos = {config, ...}: {
      imports = [inputs.nixos-wsl.nixosModules.default];

      wsl = {
        enable = true;
        defaultUser = config.host.userName;
      };
    };
  };
}
