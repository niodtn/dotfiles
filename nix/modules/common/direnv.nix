{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  feat = config.features;
  cfg = feat.direnv;
  marketplace = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
in {
  options.features.direnv = {
    enable = mkEnableOption "direnv feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      programs.direnv = {
        enable = true;
        silent = true;
        nix-direnv.enable = true;
      };

      # For VSCode
      programs.vscode.profiles.default = mkIf feat.vscode.enable {
        extensions = with marketplace; [
          mkhl.direnv
          joshx.workspace-terminals
        ];

        userSettings = {
          "direnv.restart.automatic" = true;

          "terminal.integrated.env.osx" = {
            "DIRENV_LOG_FORMAT" = "-"; # Silent for VSC
          };
        };
      };
    };
  };
}
