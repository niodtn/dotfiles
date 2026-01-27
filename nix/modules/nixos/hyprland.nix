{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.hyprland;
  username = config.username;
in {
  options.features.hyprland = {
    enable = mkEnableOption "hyprland feature";
  };
  config = mkIf cfg.enable {
    services.xserver.enable = false;
    programs.xwayland.enable = true;

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = [
      pkgs.wofi
    ];

    # Home Manager Options
    home-manager.users.${username} = {
      programs.ghostty.enable = true;

      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$mainMod" = "SUPER";
          "$menu" = "wofi --show drun";

          monitor = [",preferred,auto,1"];

          bind = [
            "$mainMod, M, exit,"
            "$mainMod, D, exec, $menu"
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
