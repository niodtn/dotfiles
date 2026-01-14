{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.direnv;

  vscodeEnabled = config.programs.vscode.enable;
  system = pkgs.stdenv.hostPlatform.system;
  marketplace = inputs.vscode-extensions.extensions.${system}.vscode-marketplace;
in {
  options.features.direnv = {
    enable = mkEnableOption "direnv feature";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };

    # For VSCode
    programs.vscode.profiles.default = mkIf vscodeEnabled {
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
}
