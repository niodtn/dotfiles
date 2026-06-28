{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    inputs.nix-flatpak = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.nix-flatpak {
    flake-file.inputs = {
      nix-flatpak.url = "github:gmodena/nix-flatpak/";
    };

    flake.aspects.core.nixos = {
      imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
    };
  };
}
