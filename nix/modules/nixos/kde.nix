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

      kdePackages.kwalletmanager
      kdePackages.kwallet-pam

      xdg-utils
    ];

    security.pam.services.kwallet = {
      name = "kwallet";
      enableKwallet = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "kde";
    };

    environment.shellAliases = {
      kde = "dbus-run-session startplasma-wayland";
    };
  };
}
