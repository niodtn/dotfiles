{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  feat = config.features;
  cfg = feat.git;
in {
  options.features.git = {
    enable = mkEnableOption "git feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      programs.git = {
        enable = true;
        settings.user.name = "niodtn";
        settings.user.email = "ipete93@gmail.com";
      };

      # For VSCode
      programs.vscode.profiles.default = mkIf feat.vscode.enable {
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
