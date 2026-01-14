{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.vscode.nix;
  system = pkgs.stdenv.hostPlatform.system;
  marketplace = inputs.vscode-extensions.extensions.${system}.vscode-marketplace;
in {
  options.features.vscode.nix = {
    enable = mkEnableOption "vscode nix feature";
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.alejandra];

    programs.vscode.profiles.default = {
      extensions = with marketplace; [
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
