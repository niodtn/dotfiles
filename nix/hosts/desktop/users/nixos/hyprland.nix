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
      # "$fileManager" = "dolphin";

      bind = [
        "$mainMod, M, exit,"
        "$mainMod, Q, exec, $terminal"
        "$mainMod, D, exec, $menu"
        # "$mainMod, E, exec, $fileManager"
      ];

      "plugin:hyprbars:bar_height" = 32;
      "plugin:hyprbars:bar_blur" = true;
      "plugin:hyprbars:bar_title_enabled" = true;
      "plugin:hyprbars:bar_text_size" = 12;
      "plugin:hyprbars:bar_buttons_alignment" = "left";
      "plugin:hyprbars:bar_padding" = 15;
      "plugin:hyprbars:bar_button_padding" = 6;
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
