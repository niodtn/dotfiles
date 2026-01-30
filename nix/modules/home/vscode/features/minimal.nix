{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.vscode.minimal;
in {
  options.features.vscode.minimal = {
    enable = mkEnableOption "vscode minimal feature";
  };

  config = mkIf cfg.enable {
    programs.vscode.profiles.default = {
      userSettings = {
        "workbench.statusBar.visible" = false;

        # Title Bar
        "window.titleBarStyle" = "native";
        "window.customTitleBarVisibility" = "never";

        # Menu Bar
        "window.menuBarVisibility" = "hidden";
      };
    };
  };
}
