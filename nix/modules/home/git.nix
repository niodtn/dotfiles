{ lib, config, pkgs, ... }:
with lib;

let
  cfg = config.features.git;

  vscodeEnabled = config.programs.vscode.enable;

in
{
  options.features.git = {
    enable = mkEnableOption "python git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings.user.name = "niodtn";
      settings.user.email = "ipete93@gmail.com";
    };

    home.shellAliases = {
      gbc = "git branch | grep -v main | xargs git branch -D && git fetch -p";
      gpod = "git push origin --delete";
      gms = "git merge --squash";
    };

    # For VSCode
    programs.vscode.profiles.default = mkIf vscodeEnabled {
      extensions = with pkgs.vscode-extensions; [
        github.vscode-pull-request-github
      ];

      userSettings = {
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.suggestSmartCommit" = false;
      };
    };
  };
}
