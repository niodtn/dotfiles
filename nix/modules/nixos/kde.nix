{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.kde;
in {
  options.features.kde = {
    enable = mkEnableOption "kde feature";
  };

  config = mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.plasma-workspace
    ];

    environment.shellAliases = {
      kde = "dbus-run-session startplasma-wayland";
    };
  };
}
