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
    services.desktopManager.plasma6.enable = true;
    # services.displayManager.sddm.wayland.enable = true;

    security.pam.services.login.enableKwallet = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kwalletmanager
    ];
    security.pam.services.kwallet = {
      name = "kwallet";
      enableKwallet = true;
    };

    xdg.portal.extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    environment.shellAliases = {
      kde = "dbus-run-session startplasma-wayland";
    };
  };
}
