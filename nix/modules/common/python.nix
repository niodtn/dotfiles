{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  feat = config.features;
  cfg = feat.python;
  marketplace = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
in {
  options.features.python = {
    enable = mkEnableOption "python feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      home.packages = [pkgs.uv];

      # For VSCode
      programs.vscode.profiles.default = mkIf feat.vscode.enable {
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
  };
}
