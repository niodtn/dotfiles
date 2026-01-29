{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  guiEnabled = config.features.gui.enable;
  cfg = config.features.gui.kde;
in {
  options.features.gui.niri = {
    enable = mkEnableOption "niri feature";
  };

  config = mkIf (guiEnabled && cfg.enable) {
    programs.niri = {
      enable = true;
      useNautilus = true;
    };
  };
}
