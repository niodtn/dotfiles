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
    ./hyprland
    ./kde.nix
  ];

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = mkDefault "*";
    };

    environment.systemPackages = [
      pkgs.xdg-utils
    ];

    services.xserver.enable = false;
    programs.xwayland.enable = true;
  };
}
