{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.python;

  vscodeEnabled = config.programs.vscode.enable;
  system = pkgs.stdenv.hostPlatform.system;
  marketplace = inputs.vscode-extensions.extensions.${system}.vscode-marketplace;
in {
  options.features.python = {
    enable = mkEnableOption "python feature";
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.uv];

    # For VSCode
    programs.vscode.profiles.default = mkIf vscodeEnabled {
      extensions = [
        marketplace.ms-python.python
        pkgs.vscode-extensions.ms-python.vscode-pylance
        marketplace.charliermarsh.ruff
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
