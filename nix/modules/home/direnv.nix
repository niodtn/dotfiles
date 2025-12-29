{ lib, config, pkgs, ... }:
with lib;

let
  cfg = config.features.direnv;

  vscodeEnabled = config.programs.vscode.enable;

in
{
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
      extensions = with pkgs.vscode-extensions; [
        mkhl.direnv
        # joshx.workspace-terminals
      ];

      userSettings = {
        "terminal.integrated.env.osx" = {
          "DIRENV_LOG_FORMAT" = "-"; # Silent for VSC
        };
      };
    };
  };
}
