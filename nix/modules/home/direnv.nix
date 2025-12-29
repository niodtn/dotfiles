{ lib, config, ... }:
with lib;

let
  vscodeEnabled = config.programs.vscode.enable;
in
{
  programs.direnv = {
    enable = true;
    silent = true;
  };

  programs.vscode.profiles.default.userSettings = mkIf vscodeEnabled {
    "terminal.integrated.env.osx" = {
      "DIRENV_LOG_FORMAT" = "-"; # Silent for VSC
    };
  };
}
