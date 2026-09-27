{
  config,
  lib,
  ...
}: let
  cfg = config.programs.atuin;
in {
  options = {
    programs.atuin = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.programs.homeManager = {
      programs.atuin = {
        enable = true;
        settings = {
          style = "auto";
          invert = true;
        };
      };
    };
  };
}
