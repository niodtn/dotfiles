{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  guiEnabled = config.features.gui.enable;
  cfg = config.features.gui.labwc;
in {
  options.features.gui.labwc = {
    enable = mkEnableOption "labwc feature";
  };

  config = mkIf (guiEnabled && cfg.enable) {
    programs.labwc.enable = true;

    environment.variables = {
      XDG_CURRENT_DESKTOP = "labwc";
      XDG_SESSION_TYPE = "wayland";
    };

    environment.systemPackages = with pkgs; [
      waybar
      sfwbar
    ];
  };
}
