{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.features.systemd-boot;
in {
  options.features.systemd-boot = {
    enable = mkEnableOption "systemd-boot feature";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
