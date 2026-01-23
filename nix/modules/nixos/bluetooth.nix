{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.bluetooth;
in {
  options.features.bluetooth = {
    enable = mkEnableOption "bluetooth feature";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };

    services.blueman.enable = true;

    environment.systemPackages = [
      pkgs.bluetui
    ];
  };
}
