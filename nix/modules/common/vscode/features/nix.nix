{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.vscode.nix;
  marketplace = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
in {
  options.features.vscode.nix = {
    enable = mkEnableOption "vscode nix feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
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
  };
}
