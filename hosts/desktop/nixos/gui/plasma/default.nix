{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./fcitx5.nix
  ];

  config = lib.mkMerge [
    # Base
    {
      xdg.portal = {
        extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
        config.kde.default = ["kde" "gtk"];
      };

      services = {
        displayManager.sddm.enable = true;
        desktopManager.plasma6.enable = true;
      };

      home-manager.users.${config.host.userName}.programs.plasma.enable = true;
    }
  ];
}
