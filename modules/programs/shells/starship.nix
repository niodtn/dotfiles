{
  config,
  lib,
  ...
}: let
  cfg = config.programs.starship;
in {
  options.programs.starship = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf cfg {
    flake.aspects.programs = {
      inputs.home-manager = true;

      homeManager = {
        programs.starship = {
          enable = true;

          settings = {
            add_newline = false;
            character.format = "> ";

            line_break.disabled = true;
            git_status.disabled = true;
            package.disabled = true;
            python.disabled = true;
          };
        };
      };
    };
  };
}
