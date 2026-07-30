{
  lib,
  config,
  ...
}: let
  cfg = config.etc.mouse;
in {
  options = {
    etc.mouse = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.host-desktop.nixos = {
      services.libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
          accelSpeed = "0";
        };
      };
    };
  };
}
