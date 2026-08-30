{
  lib,
  config,
  ...
}: let
  cfg = config.hardware.bluetooth;
in {
  options = {
    hardware.bluetooth = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.desktop.nixos = {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General.Experimental = true;
      };
    };
  };
}
