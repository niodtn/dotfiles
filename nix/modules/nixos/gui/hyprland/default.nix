{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  guiEnabled = config.features.gui.enable;
  cfg = config.features.gui.hyprland;
  username = config.username;
in {
  options.features.gui.hyprland = {
    enable = mkEnableOption "hyprland feature";
  };

  imports = [
    ./hyprbars.nix
    ./wofi.nix
  ];

  config = mkIf (guiEnabled && cfg.enable) {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = [
      pkgs.thunar
    ];

    xdg.portal.config.hyprland.default = ["hyprland" "gtk"];

    # Home Manager Options
    home-manager.users.${username} = {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$mainMod" = "SUPER";
          "$fileManager" = "thunar";

          monitor = [",preferred,auto,1"];

          bind = [
            "$mainMod, M, exit,"
            "$mainMod, E, exec, $fileManager"
          ];

          ecosystem = {
            no_update_news = true;
          };

          misc = {
            vfr = true;
          };
        };
      };
    };
  };
}
