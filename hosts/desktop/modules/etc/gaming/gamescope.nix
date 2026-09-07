{
  lib,
  config,
  ...
}: let
  cfg = config.gaming.gamescope;
in {
  options = {
    gaming.gamescope = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.desktop.nixos = {
      programs.gamescope = {
        enable = true;
        capSysNice = false;
      };

      environment.sessionVariables = {
        GAMESCOPE_ARGS = builtins.concatStringsSep " " [
          "-W 1920 -H 1080"
          "--framerate-limit 1 -r 60"
          "--immediate-flips"
        ];
      };
    };
  };
}
