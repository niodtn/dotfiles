{ lib, config, pkgs, ... }:
with lib;

let
  cfg = config.features.python;

  vscodeEnabled = config.programs.vscode.enable;

in
{
  options.features.python = {
    enable = mkEnableOption "python feature";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.uv ];

    # For VSCode
    programs.vscode.profiles.default = mkIf vscodeEnabled {
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-python.vscode-pylance
        charliermarsh.ruff
      ];

      userSettings = {
        "[python]" = {
          "editor.codeActionsOnSave" = {
            "source.organizeImports" = "explicit";
            "source.fixAll" = "explicit";
          };
          "editor.defaultFormatter" = "charliermarsh.ruff";
        };
      };
    };
  };
}
