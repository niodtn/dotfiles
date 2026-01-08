{
  lib,
  config,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.features.vscode.jupyter;

in
{
  options.features.vscode.jupyter = {
    enable = mkEnableOption "vscode jupyter feature";
  };

  config = mkIf cfg.enable {
    programs.vscode.profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
      ];
    };
  };
}
