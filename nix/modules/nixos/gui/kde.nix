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

    # kb input
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-hangul
        ];
        settings.inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
          };
          "Groups/0/Items/0" = {Name = "keyboard-us";};
          "Groups/0/Items/1" = {Name = "hangul";};
        };
      };
    };
    # environment.shellAliases = {
    #   kde = "dbus-run-session startplasma-wayland";
    # };
  };
}
