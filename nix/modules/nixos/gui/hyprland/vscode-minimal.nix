{
  lib,
  config,
  ...
}:
with lib; let
  username = config.username;
  vscodeEnabled = config.home-manager.users.${username}.programs.vscode.enable;
in {
  # Home Manager Options
  home-manager.users.${username} = {
    programs.vscode.profiles.default.userSettings = mkIf vscodeEnabled {
      "workbench.statusBar.visible" = false;

      # Title Bar
      "window.titleBarStyle" = "native";
      "window.customTitleBarVisibility" = "never";

      # Menu Bar
      "window.menuBarVisibility" = "hidden";
    };
  };
}
