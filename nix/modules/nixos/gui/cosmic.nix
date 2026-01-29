{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  guiEnabled = config.features.gui.enable;
  cfg = config.features.gui.cosmic;
in {
  options.features.gui.cosmic = {
    enable = mkEnableOption "cosmic feature";
  };

  config = mkIf (guiEnabled && cfg.enable) {
    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
