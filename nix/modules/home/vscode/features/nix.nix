{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.vscode.nix;
in {
  options.features.vscode.nix = {
    enable = mkEnableOption "vscode nix feature";
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.alejandra];

    programs.vscode.profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        kamadorueda.alejandra
      ];

      userSettings = {
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
        "alejandra.program" = "alejandra";
      };
    };
  };
}
