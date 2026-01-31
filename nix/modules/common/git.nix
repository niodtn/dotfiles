{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.git;

  vscodeEnabled = config.home-manager.users.${config.username}.programs.vscode.enable;
in {
  options.features.git = {
    enable = mkEnableOption "git feature";
  };

  config = mkIf cfg.enable {
    config.home-manager.users.${config.username} = {
      programs.git = {
        enable = true;
        settings.user.name = "niodtn";
        settings.user.email = "ipete93@gmail.com";
      };

      # For VSCode
      programs.vscode.profiles.default = mkIf options.home-manager.users.${config.username}.programs.vscode.enable {
        extensions = with pkgs.vscode-extensions; [
          # github.vscode-pull-request-github
        ];

        userSettings = {
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "git.suggestSmartCommit" = true;
          "git.mergeEditor" = true;
          "git.inputValidation" = true;

          "git.allowForcePush" = true;
          "git.confirmForcePush" = false;
        };
      };
    };
  };
}
