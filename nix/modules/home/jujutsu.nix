{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.jujutsu;

  vscodeEnabled = config.programs.vscode.enable;
  isDarwin = pkgs.stdenv.isDarwin;
  system = pkgs.stdenv.hostPlatform.system;
  marketplace = inputs.vscode-extensions.extensions.${system}.vscode-marketplace;
in {
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
      extensions =
        if isDarwin
        then [pkgs.vscode-extensions.visualjj.visualjj]
        else [marketplace.jjk.jjk];
    };
  };
}
