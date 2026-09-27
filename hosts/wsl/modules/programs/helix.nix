{
  config,
  lib,
  ...
}: let
  cfg = config.programs.helix;
in {
  options = {
    programs.helix = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    inputs.home-manager = true;

    flake.aspects.programs.homeManager = {
      programs.helix = {
        enable = true;
        defaultEditor = true;

        settings = lib.mkMerge [
          {
            editor = {
              # docs: https://docs.helix-editor.com/editor.html
              mouse = true;
              cursorline = true;
              true-color = true;

              statusline = {
                left = ["mode" "spinner" "version-control"];
                center = ["file-name"];
                right = ["diagnostics" "file-type"];

                mode.normal = "NORMAL";
                mode.insert = "INSERT";
                mode.select = "SELECT";
              };

              file-picker.hidden = false;

              indent-guides = {
                render = true;
                character = "╎";
              };

              gutters.line-numbers.min-width = 1;
            };

            keys.normal = {
              q = ":q";
              Q = ":q!";
            };
          }

          {
            theme = "base16_transparent";
            editor.cursorline = lib.mkForce false;
          }
        ];
      };
    };
  };
}
