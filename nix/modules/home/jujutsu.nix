{lib, config, pkgs, ...}:
with lib;

let
  cfg = config.features.jujutsu;

  vscodeEnabled = config.programs.vscode.enable;
in
{
  options.features.jujutsu = {
    enable = mkEnableOption "jujutsu feature";
  };

  config = mkIf cfg.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user.email = "ipegte93@gmail.com";
        user.name = "niodtn";
      };
    };

    # For VSCode
    programs.vscode.profiles.default = mkIf vscodeEnabled {
      extensions = with pkgs.vscode-extensions; [
        visualjj.visualjj
      ];
    };
  };
}
