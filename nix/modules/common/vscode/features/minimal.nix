{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.features.vscode.minimal;
in {
  options.features.vscode.minimal = {
    enable = mkEnableOption "vscode minimal feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
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
  };
}
