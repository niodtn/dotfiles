{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.vscode.remote;
in {
  options.features.vscode.remote = {
    enable = mkEnableOption "vscode remote feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      programs.vscode.profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          # ms-vscode-remote.remote-containers
          # ms-vscode-remote.remote-wsl
          ms-vscode-remote.remote-ssh
        ];

        userSettings = {
          "remote.SSH.useLocalServer" = false;
          "remote.SSH.localServerDownload" = "always";
        };
      };
    };
  };
}
