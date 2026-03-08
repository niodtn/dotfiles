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
  options.features.gui.kde = {
    enable = mkEnableOption "KDE Plasma 6 feature";
  };

  config = mkIf (guiEnabled && cfg.enable) {
    xdg.portal.config.kde.default = ["kde" "gtk"];

    environment.systemPackages = with pkgs; [
      kdePackages.kwalletmanager
    ];

    # sddm
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    # plasma
    services.desktopManager.plasma6.enable = true;
    security.pam.services.login.enableKwallet = true;

    # environment.shellAliases = {
    #   kde = "dbus-run-session startplasma-wayland";
    # };
  };
}
