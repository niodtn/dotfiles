{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.gui;
in {
  options.features.gui = {
    enable = mkEnableOption "gui feature";
  };

  imports = [
    ./cosmic.nix
    ./hyprland
    ./kde.nix
  ];

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.xdg-utils];

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.kdePackages.xdg-desktop-portal-kde
      ];
      config.common.default = ["gtk"];
    };

    services.xserver.enable = false;
    programs.xwayland.enable = true;

    users.users.${config.username}.extraGroups = ["video"];
  };
}
