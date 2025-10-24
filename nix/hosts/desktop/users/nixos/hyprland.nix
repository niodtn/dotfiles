{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hyprbars
    ];
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun";
      "$fileManager" = "dolphin";

      bind = [
        "$mainMod, M, exit,"
        "$mainMod, Q, exec, $terminal"
        "$mainMod, D, exec, $menu"
        "$mainMod, E, exec, $fileManager"
      ];

      "plugin:hyprbars:bar_height" = 20;
      "plugin:hyprbars:hyprbars-button:0" = "rgb(ff4040), 10, 󰖭, hyprctl dispatch killactive";
      "plugin:hyprbars:hyprbars-button:1" = "rgb(eeee11), 10, , hyprctl dispatch fullscreen 1";
      "plugin:hyprbars:on_double_click" = "hyprctl dispatch fullscreen 1";
    };
  };

  home = {
    packages = with pkgs; [
      kitty
      wofi
      # dolphin
    ];
  };
}
