{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.jujutsu;
in {
  options.features.jujutsu = {
    enable = mkEnableOption "jujutsu feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      programs.jujutsu = {
        enable = true;
        settings = {
          user.email = "ipegte93@gmail.com";
          user.name = "niodtn";

          ui.default-commnad = "log";
          revset-aliases."immutable_heads()" = "trunk() | tags()";
        };
      };
      # For VSCode
      programs.vscode.profiles.default = mkIf config.features.vscode.enable {
        extensions = [
          pkgs.vscode-extensions.visualjj.visualjj
        ];
      };
    };
  };
}
