{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.vscode.jupyter;
  marketplace = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform}.vscode-marketplace;
in {
  options.features.vscode.jupyter = {
    enable = mkEnableOption "vscode jupyter feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      programs.vscode.profiles.default = {
        extensions = with marketplace; [
          ms-toolsai.jupyter-keymap
          ms-toolsai.jupyter-renderers
          ms-toolsai.vscode-jupyter-cell-tags
          ms-toolsai.vscode-jupyter-slideshow
        ];
      };
    };
  };
}
