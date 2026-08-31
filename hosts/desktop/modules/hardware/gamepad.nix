{
  lib,
  config,
  ...
}: let
  cfg = config._group._name;
in {
  options = {
    _group._name = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.host-desktop.nixos = {config, ...}: {
      hardware = {
        steam-hardware.enable = true;
        xpadneo.enable = true;
      };
      users.users.${config.host.userName}.extraGroups = ["input"];
    };
  };
}
