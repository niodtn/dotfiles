{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.vscode.jupyter;
  system = pkgs.stdenv.hostPlatform.system;
  marketplace = inputs.vscode-extensions.extensions.${system}.vscode-marketplace;
in {
  options.features.vscode.jupyter = {
    enable = mkEnableOption "vscode jupyter feature";
  };

  config = mkIf cfg.enable {
    programs.vscode.profiles.default = {
      extensions = with marketplace; [
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
      ];
    };
  };
}
