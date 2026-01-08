{
  lib,
  config,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.features.vscode.nix;

in
{
  options.features.vscode.nix = {
    enable = mkEnableOption "vscode nix feature";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.nixfmt-rfc-style ];

    programs.vscode.profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];

      userSettings = {
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };
      };
    };
  };
}
