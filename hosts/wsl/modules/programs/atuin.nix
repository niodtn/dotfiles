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
        forceOverwriteSettings = true;
        flags = ["--disable-ctrl-r"];
        settings = {
          update_check = false;
          store_failed = false;

          workspaces = true;
          filter_mode = "session-preload";

          style = "auto";
          show_help = false;
          show_numeric_shortcuts = false;

          ui.columns = ["command"];
        };
      };
    };
  };
}
