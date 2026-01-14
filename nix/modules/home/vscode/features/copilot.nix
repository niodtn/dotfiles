{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.vscode.copilot;
in {
  options.features.vscode.copilot = {
    enable = mkEnableOption "vscode copilot feature";
  };

  config = mkIf cfg.enable {
    programs.vscode.profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        github.copilot
        github.copilot-chat
      ];

      userSettings = {
        "github.copilot.nextEditSuggestions.enabled" = false;
      };
    };
  };
}
