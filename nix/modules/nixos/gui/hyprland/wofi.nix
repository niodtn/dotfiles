{
  config,
  pkgs,
  ...
}: let
  username = config.username;
in {
  environment.systemPackages = [
    pkgs.wofi
  ];

  # Home Manager Options
  home-manager.users.${username} = {
    wayland.windowManager.hyprland.settings = {
      "$menu" = "wofi --show drun";

      bind = [
        "$mainMod, D, exec, $menu"
        "$mainMod, space, exec, $menu"
      ];
    };
  };
}
