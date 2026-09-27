{
  config,
  lib,
  ...
}: let
  cfg = config.programs.zellij;
in {
  options = {
    programs.zellij = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.programs.homeManager = {
      programs.zellij = {
        enable = true;
        settings = {
          show_startup_tips = false;
        };
      };
    };
  };
}
